//
//  Ship.swift
//
//
//  Created by Fernando de Lucas da Silva Gomes on 24/07/24.
//

/// A class represing a testing function
public final class Ship<Member: Vessel> {

    let id: Member
    private var error: Error? = nil
    private var value: Any? = nil
    private var _signal: Bool = false
    var statements = [Any]()

    init(id: Member) {
        self.id = id
    }

    public func action(_ action: Action) {
        switch action {
        case .deploy(let any):
            self.value = any
        case .anchor(let error):
            self.error = error
        }
    }

    func called() -> Bool {
        _signal
    }

    func signal(_ statements: [Any]) {
        _signal = true
        self.statements = statements
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
