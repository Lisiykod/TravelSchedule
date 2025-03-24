//
//  CarriersViewModel.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 23.03.2025.
//

import Foundation

final class CarriersViewModel: ObservableObject {
    @Published var carriersList: [Segments] = []
    @Published var carrier: Carrier?
    @Published var filteredCarriersList: [Segments] = []
    
    func carriers(from searchResult: SearchResult?) {
        carriersList = searchResult?.segments ?? []
        filteredCarriersList = carriersList
    }
    
    func dateFormatter(date: String, with format: String, local: String) -> String {
        let generalFormatter = DateFormatter()
        generalFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: local)
        formatter.dateFormat = format
        
        return formatter.string(from: generalFormatter.date(from: date) ?? Date())
    }
}
