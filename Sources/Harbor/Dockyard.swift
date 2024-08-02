//
//  Dockyard.swift
//
//
//  Created by Fernando de Lucas da Silva Gomes on 24/07/24.
//

public final class Dockyard<Members: Vessel> {

    private var vessels: [Ship<Members>]

    public init(vessels: [Members]) {
        self.vessels = vessels.map { .init(id: $0.id) }
    }

    func ship(vessel: Members) -> Ship<Members> {
        vessels.first(where: { vessel == $0.id })!
    }

}
