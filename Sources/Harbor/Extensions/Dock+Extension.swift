//
//  Dock+Extension.swift
//
//
//  Created by Fernando de Lucas da Silva Gomes on 04/08/24.
//  
//  LinkedIn: https://www.linkedin.com/in/fernandodelucas/
//

extension Dock {

    /// Get a ship based in the function name, the ship is a representation of a testing function
    public func ship(
        _ vessel: Vessels
    ) -> Ship<Vessels> {
        dockyard.ship(vessel: vessel)
    }

    public func check(
        ship: Vessels,
        with data: (([Any]) -> Bool)?
    ) -> Bool {
        let ship = dockyard.ship(vessel: ship)
        if let data {
            return data(ship.statements)
        }
        return ship.called()
    }

}
