//
//  SettlementsExtensions.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 03.03.2025.
//

import Foundation
import OpenAPIURLSession

typealias Settlements = Components.Schemas.SettlementsFromStationsList
typealias Stations = Components.Schemas.StationsFromStationsList
typealias Segments = Components.Schemas.Segments
typealias Carrier = Components.Schemas.Carrier

extension Settlements: Identifiable {
    var id: UUID { UUID() }
}

extension Stations: Identifiable {
    var id: UUID { UUID() }
}

extension Segments: Identifiable {
    var id: UUID { UUID() }
}
