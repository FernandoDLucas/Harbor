//
//  InheritanceClauseSyntax+Extension.swift
//  
//
//  Created by Fernando de Lucas da Silva Gomes on 26/07/24.
//  
//  LinkedIn: https://www.linkedin.com/in/fernandodelucas/
//

import SwiftSyntax

extension InheritanceClauseSyntax {
    
    static func defaultWith(_ name: String) -> InheritanceClauseSyntax {
        InheritanceClauseSyntax {
            InheritedTypeSyntax(type: IdentifierTypeSyntax(
                name: TokenSyntax(stringLiteral: name)
            ))
            InheritedTypeSyntax(type: IdentifierTypeSyntax(
                name: HarborDefinitions.classSufix.rawValue
            ))
        }
    }

}
