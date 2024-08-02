//
//  DeclModifierListSyntax+Extension.swift
//
//
//  Created by Fernando de Lucas da Silva Gomes on 26/07/24.
//  
//  LinkedIn: https://www.linkedin.com/in/fernandodelucas/
//

import SwiftSyntax

extension DeclModifierListSyntax {
    
    var containsPublicModifier: Bool {
        self.first (where: {
            $0.name.text == TokenSyntax.pub.text
        }) != nil
    }

    static func make(`public`: Bool) -> DeclModifierListSyntax {
        var decl = [DeclModifierSyntax]()
        if `public` {
            decl.append(DeclModifierSyntax(name: .pub))
        }
        return DeclModifierListSyntax(decl)
    }

}
