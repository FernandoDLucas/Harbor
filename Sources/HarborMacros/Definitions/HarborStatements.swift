//
//  HarborStatements.swift
//
//
//  Created by Fernando de Lucas da Silva Gomes on 04/08/24.
//  
//  LinkedIn: https://www.linkedin.com/in/fernandodelucas/
//

enum HarborStatements {
    case getVessel(String), throwsReturn, `return`(String), dockVar(Bool, String)

    var statement: String {
        switch self {
        case .throwsReturn:
            return "try ship.try()"
        case .getVessel(let funcName):
            return "let ship = dockyard.ship(vessel: .\(funcName))"
        case .return(let returnType):
            return "return ship\(returnType)"
        case .dockVar(let isPub, let enumName):
            let value = isPub ? "public" : "internal"
            return "\(value) var dockyard: Dockyard<\(enumName)> = .init(vessels: \(enumName).allCases)"
        }
    }

}
