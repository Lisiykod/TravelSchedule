//
//  CarriersViewModel.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 23.03.2025.
//

import Foundation

@MainActor
final class CarriersViewModel: ObservableObject {
    @Published var carriersList: [Segments] = []
    @Published var carrier: Carrier?
    @Published var filteredCarriersList: [Segments] = []
    private let generalFormatter = DateFormatter()
    private let formatter = DateFormatter()
    
    func carriers(from searchResult: SearchResult?) {
        carriersList = searchResult?.segments ?? []
        filteredCarriersList = carriersList
    }
    
    func dateFormatter(date: String, with format: String, locale: String) -> String {
        generalFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        formatter.locale = Locale(identifier: locale)
        formatter.dateFormat = format
        
        return formatter.string(from: generalFormatter.date(from: date) ?? Date())
    }
}
