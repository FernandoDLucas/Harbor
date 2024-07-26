//
//  FunctionMap.swift
//
//
//  Created by Fernando de Lucas da Silva Gomes on 26/07/24.
//  
//  LinkedIn: https://www.linkedin.com/in/fernandodelucas/
//

import SwiftSyntax

extension FunctionDeclSyntax {

    var isThrowing: Bool {
        guard let specifiers = signature.effectSpecifiers else {
            return false
        }
        return specifiers.throwsSpecifier != nil
    }

}
