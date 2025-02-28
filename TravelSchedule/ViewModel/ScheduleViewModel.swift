//
//  ScheduleViewModel.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 23.02.2025.
//

import Foundation
import OpenAPIURLSession

typealias Settlements = Components.Schemas.SettlementsFromStationsList
typealias Stations = Components.Schemas.StationsFromStationsList
typealias Segments = Components.Schemas.Segments
typealias Carrier = Components.Schemas.Carrier

enum Direction {
    case from
    case to
}

enum ErrorsType: Error {
    case serverError
    case internetConnectError
}

final class ScheduleViewModel: ObservableObject {
    
    @Published var allSettlements: [Settlements] = []
    @Published var stations: [Stations] = []
    @Published var fromSettlemet: Settlements?
    @Published var toSettlemet: Settlements?
    @Published var fromStation: Stations?
    @Published var toStation: Stations?
    @Published var carriersList: [Segments] = []
    @Published var carrier: Carrier?
    @Published var isLoading: Bool = true
    
    private let navigationService = NavigationService.shared
    
    init() {
        Task {
            await getAllSettlements()
        }
    }
    
    @MainActor
    private func getAllSettlements() async {
        var stationList: [Settlements] = []
        let testSettlements = ["Москва", "Санкт-Петербург", "Сочи", "Горный Воздух", "Краснодар", "Казань", "Омск"]
        do {
            let allStationsList = try await getStationsList()
            for country in allStationsList.countries ?? [] {
                for region in country.regions ?? [] {
                    for city in region.settlements ?? [] {
                        if testSettlements.contains(city.title ?? "") {
                            stationList.append(city)
                        }
                    }
                }
            }
        } catch ErrorsType.internetConnectError {
            addPath(with: Route.noInternetView)
        } catch ErrorsType.serverError {
            addPath(with: Route.serverErrorView)
        } catch {
            print(error.localizedDescription)
        }
        
        allSettlements = stationList.filter { $0.title != ""}
        isLoading = allSettlements.isEmpty ? true : false
        allSettlements.sort {$0.title! < $1.title! }
    }
    
    func setSettlementsStations(on settlement: Settlements, direction: Direction) {
        let allStations = settlement.stations ?? []
        stations = allStations.filter { $0.station_type == "train_station" || $0.transport_type == "train" }
        stations.sort {$0.title! < $1.title! }
        
        switch direction {
        case .from:
            fromSettlemet = settlement
        case .to:
            toSettlemet = settlement
        }
    }
    
    func setStation(station: Stations, direction: Direction) {
        switch direction {
        case .from:
            fromStation = station
        case .to:
            toStation = station
        }
    }
    
    func changeDirection() {
        swap(&fromSettlemet, &toSettlemet)
        swap(&fromStation, &toStation)
    }
    
    @MainActor
    func search() async {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: Date())
        
        let client = createClient()
        guard let client else { return }
        
        let service = SearchService(
            client: client,
            apiKey: Constants.apiKey
        )
        guard let fromCode = fromStation?.codes?.yandex_code,
              let toCode = toStation?.codes?.yandex_code else { return }
        
        do {
            let searchResult = try await service.getSearchResult(from: fromCode, to: toCode, on: date, transportType: "train", transfers: true)
            carriersList = searchResult.segments ?? []
        } catch ErrorsType.internetConnectError {
            addPath(with: Route.noInternetView)
        } catch ErrorsType.serverError {
            addPath(with: Route.serverErrorView)
        } catch {
            print(String(describing: error))
        }
        
        isLoading = false
    }
    
    func dateFormatter(from date: String, with format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale.current
        let dateFromString = dateFormatter.date(from: date)
        return dateFormatter.string(from: dateFromString ?? Date())
    }
    
    func addPath(with route: Route) {
        navigationService.push(route: route)
    }
    
    func backToRoot() {
        navigationService.popRoot()
    }
    // MARK: - Services

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
    
//        private func getSearch(date: String? = nil, transportType: String, transfers: Bool) throws -> SearchResult? {
//            let client = createClient()
//            guard let client else { return nil }
//    
//            let service = SearchService(
//                client: client,
//                apiKey: Constants.apiKey
//            )
//            guard let fromCode = fromStation?.codes?.yandex_code,
//                  let toCode = toStation?.codes?.yandex_code else { return nil }
//    
//            var search: SearchResult?
//            Task {
//                do {
//                    search = try await service.getSearchResult(from: fromCode, to: toCode, on: date, transportType: transportType, transfers: transfers)
//                    print("search \(String(describing: search))")
//                } catch {
//                    throw ErrorsType.serverError
//                }
//            }
//            return search
//        }
//    
    
    private func getStationsList() async throws -> StationsList {
        let client = createClient()
        guard let client else { return StationsList() }
        
        let service = StationsListService(
            client: client,
            apiKey: Constants.apiKey
        )
        let stationsList = try await service.getStationsList()
        return stationsList
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
