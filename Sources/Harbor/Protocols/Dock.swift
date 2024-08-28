//
//  Dock.swift
//
//
//  Created by Fernando de Lucas da Silva Gomes on 23/07/24.
//

/// A protocol to define a mockable class
public protocol Dock {

    associatedtype Vessels: Vessel

    var dockyard: Dockyard<Vessels> { get }

}
