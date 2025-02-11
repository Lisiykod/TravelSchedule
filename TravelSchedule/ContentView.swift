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
            Button("print selected response") {
                stations()
//                settlements()
//                carrier() 
//                copyright()
//                thread()
//                schedule()
//                search()
//                stationsList()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
    
    func stations() {
        let client = client()
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
                print("error responce: \(error.localizedDescription)")
            }
        }
    }
    
    func settlements() {
        let client = client()
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
                print("error responce: \(error.localizedDescription)")
            }
        }
    }
    
    func carrier() {
        let client = client()
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
                print("error responce: \(error.localizedDescription)")
            }
        }
    }
    
    
    func copyright() {
        let client = client()
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
                print("error responce: \(error.localizedDescription)")
            }
        }
    }
    
    func thread() {
        let client = client()
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
                print("error responce: \(error.localizedDescription)")
            }
        }
    }
    
    func schedule() {
        let client = client()
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
                print("error responce: \(error.localizedDescription)")
            }
        }
    }
    
    func search() {
        let client = client()
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
                print("error responce: \(error.localizedDescription)")
            }
        }
    }
    
    func stationsList() {
        let client = client()
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
                print("error responce: \(error.localizedDescription)")
            }
        }
    }
    
    private func client() -> Client? {
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
