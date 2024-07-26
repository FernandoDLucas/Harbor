//
//  FunctionFactory.swift
//
//
//  Created by Fernando de Lucas da Silva Gomes on 26/07/24.
//  
//  LinkedIn: https://www.linkedin.com/in/fernandodelucas/
//

import SwiftSyntax

enum FunctionFactory {

    static func make(
        _ block: MemberBlockSyntax,
        makePublic: Bool
    ) throws -> MemberBlockItemListSyntax {
        try MemberBlockItemListSyntax {
            let functions = block
                .members
                .compactMap {
                    $0.decl.as(FunctionDeclSyntax.self)
                }
            for function in functions {
                try MemberBlockItemSyntax(decl: make(function, makePublic: makePublic))
            }
        }
    }

    static func make(
        _ function: FunctionDeclSyntax,
        makePublic: Bool
    ) throws -> FunctionDeclSyntax {
        var copyFunc = function
        if makePublic {
            let pubModifier = DeclModifierSyntax(name: .pub)
            copyFunc.modifiers.append(pubModifier)
        }
        copyFunc.body = .init(statements: try makeBody(function: function))
        return copyFunc
    }

    static func makeBody(function: FunctionDeclSyntax) throws -> CodeBlockItemListSyntax {
        try CodeBlockItemListSyntax {
            try CodeBlockItemSyntax(stringLiteral: makeReturn(function: function))
        }
    }

    static func makeReturn(function: FunctionDeclSyntax) throws -> String {
        let funcName = function.funcName
        let signature = function.signature
        var throwsDecl: String = ""

        if let _ = signature.effectSpecifiers?.throwsSpecifier {
            throwsDecl = HarborStatements.throwsReturn(funcName).statement
            if signature.returnClause == nil {
                return throwsDecl
            }
        }
        let returnType = try HarborReturnFactory.findReturnType(signature.returnClause)

        return """
            \(throwsDecl)
            \(HarborStatements.return(funcName, returnType).statement)
        """
    }

}


enum HarborReturnFactory {

    static func findReturnType(_ clause: ReturnClauseSyntax?) throws -> String {
        guard let clause,
                let returnType = clause.type.as(IdentifierTypeSyntax.self) else {
                guard let optionalReturn = clause?.type.as(OptionalTypeSyntax.self),
                  let wrappedType = optionalReturn.wrappedType.as(IdentifierTypeSyntax.self) else {
                    throw DockError.returnClauseNotMapped(clause?.type as Any)
            }
            let wrappedName = wrappedType.name
            return ".asType(\(wrappedName).self)"
        }
        let returnName = returnType.name.text
        if returnName.contains("Result") {
            return ".result()"
        } else {
            return ".as(\(returnName).self)"
        }
    }

}
