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
    case getVessel(String), throwsReturn, `return`(String), dockVar(String)

    var statement: String {
        switch self {
        case .throwsReturn:
            return "try ship.try()"
        case .getVessel(let funcName):
            return "let ship = dockyard.ship(vessel: .\(funcName))"
        case .return(let returnType):
            return "return ship\(returnType)"
        case .dockVar(let enumName):
            return "var dockyard: Dockyard<\(enumName)> = .init(vessels: \(enumName).allCases)"
        }
    }
}
