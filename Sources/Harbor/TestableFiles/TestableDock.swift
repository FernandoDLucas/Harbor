//
//  CargoShip.swift
//
//
//  Created by Fernando de Lucas da Silva Gomes on 22/07/24.
//  LinkedIn: https://www.linkedin.com/in/fernandodelucas/
//

import Foundation

@Dock
public protocol CargoShip {

    func currentCargo() -> Int
    func findCargo(id: UUID) -> Cargo?
    func loadCargo(
        name: String,
        weight: Int
    ) -> Result<Cargo, Error>
    func removeCargo() throws -> Cargo?
    func update(
        id: UUID,
        weight: Int
    ) throws -> [String]

}
