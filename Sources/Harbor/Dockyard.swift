//
//  Dockyard.swift
//
//
//  Created by Fernando de Lucas da Silva Gomes on 24/07/24.
//

public final class Dockyard<Members: Identifiable> {

    private var vessels: [Ship]

    init(vessels: [Members]) {
        self.vessels = vessels.map { .init(id: $0.id) }
    }

    func ship(vessel: Members) -> Ship {
        vessels.first(where: { vessel.id.hashValue == $0.id.hashValue })!
    }

}
