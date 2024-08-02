//
//  EnumIdentifiable.swift
//
//
//  Created by Fernando de Lucas da Silva Gomes on 31/07/24.
//  
//  LinkedIn: https://www.linkedin.com/in/fernandodelucas/
//

import Foundation

public protocol EnumIdentifiable: RawRepresentable, Identifiable, CaseIterable, Equatable {}

extension EnumIdentifiable {
    public var id: Self {
        self
    }
}
