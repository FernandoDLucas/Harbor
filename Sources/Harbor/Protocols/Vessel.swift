//
//  File.swift
//  
//
//  Created by Fernando de Lucas da Silva Gomes on 23/07/24.
//

public protocol Vessel: RawRepresentable, Identifiable, CaseIterable where RawValue == String {}

extension Vessel {
    public var id: Self {
        self
    }
}
