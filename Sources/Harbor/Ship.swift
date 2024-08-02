//
//  Ship.swift
//
//
//  Created by Fernando de Lucas da Silva Gomes on 24/07/24.
//

import Foundation

public final class Ship<Member: Vessel> {

    let id: Member
    public var error: Error? = nil
    public var value: Any? = nil
    public private (set) var invoked: Bool = false
    public private (set) var parameters = [Any]()

    public init(id: Member) {
        self.id = id
    }

    public func deploy(_ value: Any?) {
        self.value = value
    }

    public func anchor(_ error: Error) {
        self.error = error
    }

    public func invoke(_ parameters: [Any]) {
        invoked = true
        self.parameters = parameters
    }

    public func result<S>() -> Result<S, Error> {
        if let error {
            return .failure(error)
        }
        return .success(value as! S)
    }

    public func `as`<S>(_ type: S.Type) -> S {
        guard let V = value as? S else {
            fatalError("Could not cast")
        }
        return V
    }

    public func `asType`<S>(_ type: S.Type) -> S? {
        return value as? S
    }

    public func `try`() throws {
        if let error {
            throw error
        }
    }

}
