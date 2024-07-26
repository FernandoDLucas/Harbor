//
//  ProtocolAtlas.swift
//  
//
//  Created by Fernando de Lucas da Silva Gomes on 26/07/24.
//  
//  LinkedIn: https://www.linkedin.com/in/fernandodelucas/
//

import SwiftSyntax

enum ProtocolAtlas {
    
    static func mapProtocol(_ decl: DeclSyntaxProtocol) throws -> ProtocolDeclSyntax {
        guard let protocolDecl = decl.as(ProtocolDeclSyntax.self) else {
            throw DockError.isNotProtocol
        }
        return protocolDecl
    }

}
