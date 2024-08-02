//
//  EnumFactory.swift
//
//
//  Created by Fernando de Lucas da Silva Gomes on 26/07/24.
//
//  LinkedIn: https://www.linkedin.com/in/fernandodelucas/
//

import SwiftSyntax

enum EnumFactory {
    
    static func make(
        named: TokenSyntax,
        funcs: [FunctionMap]
    ) throws -> EnumDeclSyntax {
        let typeList = InheritedTypeListSyntax {
            InheritedTypeSyntax(type: IdentifierTypeSyntax(name: "String"))
            InheritedTypeSyntax(type: IdentifierTypeSyntax(name: "Vessel"))
        }
        return .init(
            name: named,
            inheritanceClause: InheritanceClauseSyntax(inheritedTypes: typeList),
            memberBlock: try makeBlock(funcs: funcs)
        )
    }
    
    static func makeNestedBlock(function: FunctionMap) throws -> StructDeclSyntax {
        return StructDeclSyntax(
            name: "\(raw: function.harborName)Declaration",
            memberBlock: try MemberBlockSyntax {
                for parameter in function.decl.signature.parameterClause.parameters {
                    try MemberBlockItemSyntax(decl: makeVarDecl(parameter: parameter))
                }
            }
        )
    }

    static func makeVarDecl(parameter: FunctionParameterSyntax) throws -> DeclSyntax {
        .init(stringLiteral:
        """
            public var \(parameter.firstName.text): \(parameter.type.as(IdentifierTypeSyntax.self)!.name.text)?
        """
        )
    }

    static func makeBlock(funcs: [FunctionMap]) throws -> MemberBlockSyntax {
        let funcList = funcs.map { $0.harborName }.joined(separator: ",")
        return try MemberBlockSyntax {
            try MemberBlockItemListSyntax {
                try MemberBlockItemSyntax(decl: makeCase(funcList: funcList))
//                for function in funcs {
//                    if !function.decl.parametersAreEmpty {
//                        try makeNestedBlock(function: function)
//                    }
//                }
            }
        }
    }
    
    static func makeCase(funcList: String) throws -> DeclSyntax {
        .init(stringLiteral:
        """
        case \(funcList)
        """
        )
    }
    
}
