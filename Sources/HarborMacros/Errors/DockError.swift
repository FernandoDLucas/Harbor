//
//  DockError.swift
//  
//
//  Created by Fernando de Lucas da Silva Gomes on 26/07/24.
//  
//  LinkedIn: https://www.linkedin.com/in/fernandodelucas/
//

enum DockError: Error, CustomStringConvertible {

    case isNotProtocol, isNotFunction(Any), typeNotMapped(Any)
    
    var description: String {
        switch self {
        case .isNotProtocol:
            "@Dock can only be used at the top of protocol declarations"
        case .isNotFunction(let arg):
            "Argument \(arg) is not a function"
        case .typeNotMapped(let arg):
            "Type \(arg) is not mapped on DockErrorFactory"
        }
    }

}
