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
        
//        NavigationStack {
            TabView {
                ScheduleView()
                    .tabItem {
                        Image("arrowUpIcon")
                            .renderingMode(.template)
                    }
                
                SettingsView()
                    .tabItem {
                        Image("SettingsIcon")
                            .renderingMode(.template)
                    }
            }
            .accentColor(.ypBlack)
//        }
            
            //            Button("print stations") {
            //                getStations()
            //            }
            //
            //            Button("print settlements") {
            //                getSettlements()
            //            }
            //
            //            Button("print carrier") {
            //                getCarrier()
            //            }
            //
            //            Button("print copyright") {
            //                getCopyright()
            //            }
            //
            //            Button("print thread") {
            //                getThread()
            //            }
            //
            //            Button("print schedule") {
            //                getSchedule()
            //            }
            //
            //            Button("print search") {
            //                getSearch()
            //            }
            //
            //            Button("print stationsList") {
            //                getStationsList()
            //            }
//        }
//        .buttonStyle(.borderedProminent)
//        .padding()
        
        
    }
    
    
    private func getStations() {
        let client = createClient()
        guard let client else { return }
        
        let service = NearestStationsService(
            client: client,
            apiKey: Constants.apiKey
        )
        
        Task {
            do {
                let stations = try await service.getNearestStations(lat: 59.864177, lng: 30.319163, distance: 50)
                print("nearest stations: \(stations)")
            } catch {
                print("error response: \(error.localizedDescription)")
            }
        }
    }
    
    private func getSettlements() {
        let client = createClient()
        guard let client else { return }
        
        let service = NearestSettlementService(
            client: client,
            apiKey: Constants.apiKey
        )
        
        Task {
            do {
                let settlements = try await service.getNearestSettlement(
                    lat: 54.513678,
                    lng: 36.261341
                )
                print("settlements: \(settlements)")
            } catch {
                print("error response: \(error.localizedDescription)")
            }
        }
    }
    
    private func getCarrier() {
        let client = createClient()
        guard let client else { return }
        
        let service = CarrierInfoService(
            client: client,
            apiKey: Constants.apiKey
        )
        
        Task {
            do {
                let carrier = try await service.getCarrierInfo(code: "680")
                print("carrier: \(carrier)")
            } catch {
                print("error response: \(error.localizedDescription)")
            }
        }
    }
    
    
    private func getCopyright() {
        let client = createClient()
        guard let client else { return }
        
        let service = CopyrightService(
            client: client,
            apiKey: Constants.apiKey
        )
        
        Task {
            do {
                let copyright = try await service.getCopyrigth()
                print("copyright: \(copyright)")
            } catch {
                print("error response: \(error.localizedDescription)")
            }
        }
    }
    
    private func getThread() {
        let client = createClient()
        guard let client else { return }
        
        let service = ThreadService(
            client: client,
            apiKey: Constants.apiKey
        )
        
        Task {
            do {
                let thread = try await service.getThread(uid: "UJ-615_250211_c1764_12")
                print("thread: \(thread)")
            } catch {
                print("error response: \(error.localizedDescription)")
            }
        }
    }
    
    private func getSchedule() {
        let client = createClient()
        guard let client else { return }
        
        let service = ScheduleService(
            client: client,
            apiKey: Constants.apiKey
        )
        
        Task {
            do {
                let schedule = try await service.getSchedule(station: "s9600213")
                print("schedule: \(schedule)")
            } catch {
                print("error response: \(error.localizedDescription)")
            }
        }
    }
    
    private func getSearch() {
        let client = createClient()
        guard let client else { return }
        
        let service = SearchService(
            client: client,
            apiKey: Constants.apiKey
        )
        
        Task {
            do {
                let search = try await service.getSearchResult(from: "c146", to: "c213", on: "2025-02-12")
                print("search: \(search)")
            } catch {
                print("error response: \(error.localizedDescription)")
            }
        }
    }
    
    private func getStationsList() {
        let client = createClient()
        guard let client else { return }
        
        let service = StationsListService(
            client: client,
            apiKey: Constants.apiKey
        )
        
        Task {
            do {
                let stationsList = try await service.getStationsList()
                print("stationsList: \(stationsList)")
            } catch {
                print("error response: \(error.localizedDescription)")
            }
        }
    }
    
    private func createClient() -> Client? {
        var url: URL?
        
        do {
            url = try Servers.Server1.url()
        } catch {
            print(String(describing: error))
        }
        
        guard let url else {
            return nil
        }
        
        let client = Client(
            serverURL: url,
            transport: URLSessionTransport()
        )
        
        return client
    }
    
}

#Preview {
    ContentView()
}
