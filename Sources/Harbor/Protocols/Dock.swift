//
//  File.swift
//  
//
//  Created by Fernando de Lucas da Silva Gomes on 23/07/24.
//

public protocol Dock {

    associatedtype Vessels: Vessel
    var dockyard: Dockyard<Vessels> { get }

}

extension Dock {

    func ship(
        _ vessel: Vessels
    ) -> Ship {
        dockyard.ship(vessel: vessel)
    }

}
