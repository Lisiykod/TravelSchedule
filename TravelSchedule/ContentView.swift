//
//  ContentView.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 07.02.2025.
//

import SwiftUI
import OpenAPIURLSession

struct ContentView: View {
    var body: some View {
        VStack {
            Button("get responce") {
//                stations()
                settlements()
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
    
    func stations() {
        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        
        let service = NearestStationsService(
            client: client,
            apiKey: Constants.apiKey
        )
        
        Task {
            let stations = try await service.getNearestStations(lat: 59.864177, lng: 30.319163, distance: 50)
            print(stations)
        }
    }
    
    func settlements() {
        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        
        let service = NearestSettlementService(
            client: client,
            apiKey: Constants.apiKey
        )
        
        Task {
            let settlements = try await service.getNearestSettlement(
                lat: 54.513678,
                lng: 36.261341
            )
            print(settlements)
        }
    }
    
    
}

#Preview {
    ContentView()
}
