//
//  FunctionAtlas.swift
//
//
//  Created by Fernando de Lucas da Silva Gomes on 26/07/24.
//  
//  LinkedIn: https://www.linkedin.com/in/fernandodelucas/
//

import SwiftSyntax

enum FunctionAtlas {

    static func mapFunctions(_ block: MemberBlockSyntax) throws -> [FunctionMap] {
        let functions = block
            .members
            .compactMap {
                $0.decl.as(FunctionDeclSyntax.self)
            }
            .map {
                FunctionMap(
                    harborName: $0.funcName,
                    decl: $0
                )
            }
        return addNumberToRepeatedNames(in: functions, keyPath: \.harborName)
    }


}
