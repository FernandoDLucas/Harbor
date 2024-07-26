//
//  TokenSyntax+Extension.swift
//
//
//  Created by Fernando de Lucas da Silva Gomes on 26/07/24.
//  
//  LinkedIn: https://www.linkedin.com/in/fernandodelucas/
//

import SwiftSyntax

extension TokenSyntax {
    
    static var pub: TokenSyntax {
        .keyword(.public)
    }

    static var `final`: TokenSyntax {
        .keyword(.final)
    }

}
