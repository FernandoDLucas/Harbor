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

    static func mapFunction(_ block: MemberBlockSyntax) throws -> [FunctionDeclSyntax] {
        try block
            .members
            .compactMap { $0.decl.as(FunctionDeclSyntax.self) }
            .map { try mapFunction($0) }
    }

    static func mapFunction(_ decl: [FunctionDeclSyntax]) throws -> [FunctionDeclSyntax] {
        try decl.map { try mapFunction($0) }
    }

    static func mapFunction(_ decl: FunctionDeclSyntax) throws -> FunctionDeclSyntax {
        guard let functionDecl = decl.as(FunctionDeclSyntax.self) else {
            throw DockError.isNotFunction(decl)
        }
        return functionDecl
    }

}
