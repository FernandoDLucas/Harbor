//
//  TypeAliasFactory.swift
//
//
//  Created by Fernando de Lucas da Silva Gomes on 26/07/24.
//  
//  LinkedIn: https://www.linkedin.com/in/fernandodelucas/
//

import SwiftSyntax

enum TypeAliasFactory {
    
    static func make(
        named: TokenSyntax,
        isPublic: Bool
    ) -> TypeAliasDeclSyntax {
        let identifier = IdentifierTypeSyntax(name: named)
        return .init(
            modifiers: .make(public: isPublic),
            name: HarborDefinitions.typeAliasTitle.rawValue,
            initializer: TypeInitializerClauseSyntax(value: identifier)
        )
    }

}
