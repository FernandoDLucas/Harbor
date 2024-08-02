//
//  FunctionFactory.swift
//
//
//  Created by Fernando de Lucas da Silva Gomes on 26/07/24.
//
//  LinkedIn: https://www.linkedin.com/in/fernandodelucas/
//

import SwiftSyntax

struct FunctionMap {
    
    var harborName: String
    var decl: FunctionDeclSyntax
    
    init(harborName: String, decl: FunctionDeclSyntax) {
        self.harborName = harborName
        self.decl = decl
    }
    
}

enum FunctionFactory {
    
    static func make(
        functions: [FunctionMap],
        makePublic: Bool
    ) throws -> MemberBlockItemListSyntax {
        try MemberBlockItemListSyntax {
            for function in functions {
                try MemberBlockItemSyntax(decl: make(function, makePublic: makePublic))
            }
        }
    }
    
    static func make(
        _ function: FunctionMap,
        makePublic: Bool
    ) throws -> FunctionDeclSyntax {
        var copyFunc = function
        if makePublic {
            let pubModifier = DeclModifierSyntax(name: .pub)
            copyFunc.decl.modifiers.append(pubModifier)
        }
        copyFunc.decl.body = .init(statements: try makeBody(function: function))
        return copyFunc.decl
    }
    
    static func makeBody(function: FunctionMap) throws -> CodeBlockItemListSyntax {
        try CodeBlockItemListSyntax {
            try CodeBlockItemSyntax(stringLiteral: makeReturn(function: function))
        }
    }
    
    static func makeReturn(function: FunctionMap) throws -> String {
        let funcName = function.harborName
        let signature = function.decl.signature
        let defaultDecl = HarborStatements.getVessel(funcName).statement
        let spy = "ship.invoke([\(function.decl.parametersList)])"
        var throwsDecl: String = ""
        
        if let _ = signature.effectSpecifiers?.throwsSpecifier {
            throwsDecl = HarborStatements.throwsReturn.statement
            if signature.returnClause == nil {
                return """
            \(defaultDecl)
            \(spy)
            return \(throwsDecl)
            """
            }
        }
        var returnType: String {
            if let returnValue = HarborReturnFactory.findReturnType(signature.returnClause) {
                return HarborStatements.return(returnValue).statement
            }
            return ""
        }
        
        return """
            \(defaultDecl)
            \(spy)
            \(throwsDecl)
            \(returnType)
        """
    }
    
}


enum HarborReturnFactory {
    
    static func findReturnType(_ clause: ReturnClauseSyntax?) -> String? {
        guard let clause,
              let returnType = clause.type.as(IdentifierTypeSyntax.self) else {
            guard let optionalReturn = clause?.type.as(OptionalTypeSyntax.self),
                  let wrappedType = optionalReturn.wrappedType.as(IdentifierTypeSyntax.self) else {
                return nil
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

func findType(
    _ type: TypeSyntax
) throws -> IdentifierTypeSyntax {
    guard let typeIdentifier = type.as(IdentifierTypeSyntax.self) else {
        guard let optionalIdentifier = type.as(OptionalTypeSyntax.self),
              let optionalType = optionalIdentifier.wrappedType.as(IdentifierTypeSyntax.self) else {
            throw DockError.typeNotMapped(type as Any)
        }
        return optionalType
    }
    return typeIdentifier
}

extension Array where Element == String {
    
    func addNumberToRepeatedNames() -> [String] {
        var counts: [String: Int] = [:]
        
        return self.enumerated().map { (index, element) in
            if let counting = counts[element] {
                counts[element] = counting+1
                return "\(element)\(counting + 1)"
            } else {
                counts[element] = 1
                return element
            }
        }
    }
    
}

func addNumberToRepeatedNames<T>(in array: [T], keyPath: WritableKeyPath<T, String>) -> [T] {
    var counts: [String: Int] = [:]
    
    return array.enumerated().map { (index, element) in
        var name = element[keyPath: keyPath]
        var copyElement = element
        if let counting = counts[name] {
            counts[name] = counting+1
            copyElement[keyPath: keyPath] = "\(name)\(counting+1)"
        } else {
            counts[name] = 1
        }
        return copyElement
    }
}
