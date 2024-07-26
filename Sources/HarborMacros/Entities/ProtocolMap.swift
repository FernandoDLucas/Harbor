//
//  ProtocolMap.swift
//
//
//  Created by Fernando de Lucas da Silva Gomes on 25/07/24.
//

import SwiftSyntax

extension ProtocolDeclSyntax {

    var declName: String {
        self.name.text
    }

    var isPublic: Bool {
        modifiers.containsPublicModifier
    }

    var functions: [FunctionDeclSyntax] {
        self.memberBlock.members.compactMap {
            $0.decl.as(FunctionDeclSyntax.self)
        }
    }

    var functionsList: String {
        functions.map { $0.funcName }.joined(separator: ",")
    }

}
