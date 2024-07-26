//
//  File.swift
//
//
//  Created by Fernando de Lucas da Silva Gomes on 22/07/24.
//

import Foundation

struct Cargo {
    let id = UUID()
    let productName: String
    let weight: Int
}
@Dock
protocol CargoShip {

    func currentCargo() -> Int
    func findCargo(id: UUID) -> Cargo?
    func loadCargo(
        name: String,
        weight: Int
    ) -> Result<Cargo, Error>
    func removeCargo() throws -> Cargo?
    func update(id: UUID, weight: Int) throws
    func update<V>(id: V) -> String
}



final class Tests: Dock {
    var dockyard: Dockyard<somVess> = .init(vessels: somVess.allCases)

    typealias Vessels = somVess

    enum somVess: String, Vessel {
        case so
    }
}
