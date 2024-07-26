//
//  HarborDefinitions.swift
//
//
//  Created by Fernando de Lucas da Silva Gomes on 26/07/24.
//  
//  LinkedIn: https://www.linkedin.com/in/fernandodelucas/
//

import SwiftSyntax

enum HarborDefinitions: TokenSyntax {
    case typeAliasTitle = "Vessels",
         functionsName = "Ships",
         classSufix = "Dock"
         
}

enum HarborStatements {
    case throwsReturn(String), `return`(String, String), dockVar(String)
    
    var statement: String {
        switch self {
        case .throwsReturn(let funcName):
            return "try dockyard.ship(vessel: .\(funcName)).try()"
        case .return(let funcName, let returnType):
            return "return dockyard.ship(vessel: .\(funcName))\(returnType)"
        case .dockVar(let enumName):
            return "var dockyard: Dockyard<\(enumName)> = .init(vessels: \(enumName).allCases)"
        }
    }
}
