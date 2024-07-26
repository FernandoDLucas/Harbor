//
//  RandomAccessCollection+Extension.swift
//
//
//  Created by Fernando de Lucas da Silva Gomes on 25/07/24.
//

extension RandomAccessCollection {

    func toLiteral() -> String {
        let arrayLiteralString = self.map { "\($0)" }.joined(separator: ", ")
        return "[\(arrayLiteralString)]"
    }

}
