//
//  FiltersViewModel.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 23.03.2025.
//

import Foundation

@MainActor
final class FiltersViewModel: ObservableObject {
    @Published var departureTimeIntervals: [DepartureTimeInterval] = []
    @Published var isFilter: Bool = false
    @Published var hasTransfers: Bool = true
    private let dateFormatter = DateFormatter()
    
    func setFilters(for carriersList: [Segments]) -> [Segments] {
        var filteredCarriers = carriersList
        
        if !departureTimeIntervals.isEmpty {
            filteredCarriers = filteredCarriers.filter { segment in
                guard let departure = segment.departure else { return false }
                let hour = departureTime(departure: departure)
                
                switch hour {
                case 6..<12: return departureTimeIntervals.contains(.morning)
                case 12..<18: return departureTimeIntervals.contains(.afternoon)
                case 18..<23: return departureTimeIntervals.contains(.evening)
                case 0..<6, 23...23: return departureTimeIntervals.contains(.night) // Учтен 23 час
                default: return false
                }
            }
        }
        
        if !hasTransfers {
            filteredCarriers = filteredCarriers.filter {$0.has_transfers == false }
        }
        
        return filteredCarriers
    }
    
    private func departureTime(departure: String) -> Int {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let hour = Calendar.current.component(.hour, from: dateFormatter.date(from: departure) ?? Date())
        return hour
    }
    
    
}
