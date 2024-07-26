//
//  Ship.swift
//
//
//  Created by Fernando de Lucas da Silva Gomes on 24/07/24.
//

import Foundation

public final class Ship {

    let id: any Hashable
    var error: Error?
    var value: Any?

    init(
        id: any Hashable,
        error: Error? = nil,
        value: Any? = nil
    ) {
        self.id = id
        self.error = error
        self.value = value
    }

    public func deploy(_ value: Any?) {
        self.value = value
    }

    public func anchor(_ error: Error) {
        self.error = error
    }

    func result<S>() -> Result<S, Error> {
        if let error {
            return .failure(error)
        }
        return .success(value as! S)
    }

    func `as`<S>(_ type: S.Type) -> S {
        guard let V = value as? S else {
            fatalError("Could not cast")
        }
        return V
    }

    func `asType`<S>(_ type: S.Type) -> S? {
        return value as? S
    }

    func `try`() throws {
        if let error {
            throw error
        }
    }

}
