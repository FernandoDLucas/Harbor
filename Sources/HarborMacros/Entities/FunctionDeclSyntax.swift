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
    
    var parametersList: String {
        self.signature.parameterClause.parameters.compactMap {
            if let secondName = $0.secondName {
                return secondName
            }
            return $0.firstName
        }
        .compactMap {
            $0.text
        }
        .addNumberToRepeatedNames().joined(separator: ",")
    }
    
    var parametersAreEmpty: Bool {
        self.signature.parameterClause.parameters.isEmpty
    }

}
