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
        for prot: ProtocolDeclSyntax
    ) throws -> EnumDeclSyntax {
        let typeList = InheritedTypeListSyntax {
            InheritedTypeSyntax(type: IdentifierTypeSyntax(name: "String"))
            InheritedTypeSyntax(type: IdentifierTypeSyntax(name: "Vessel"))
        }
        return .init(
            name: named,
            inheritanceClause: InheritanceClauseSyntax(inheritedTypes: typeList),
            memberBlock: try makeBlock(funcList: prot.functionsList)
        )
    }

    static func makeBlock(funcList: String) throws -> MemberBlockSyntax {
        try MemberBlockSyntax {
            try MemberBlockItemListSyntax {
                try MemberBlockItemSyntax(decl: makeCase(funcList:funcList))
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
