//
//  ScheduleViewModel.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 23.02.2025.
//

import Foundation
import OpenAPIURLSession
import OpenAPIRuntime

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
    @Published var isFilter: Bool = false
    @Published var filteredCarriersList: [Segments] = []
    @Published var departureTimeIntervals: [DepartureTimeInterval] = []
    @Published var hasTransfers: Bool = true
    
    private let navigationService = NavigationService.shared
    
    // MARK: - Initializer
    init() {
        Task {
            await getAllSettlements()
        }
    }
    
    // MARK: - Public Methods
    
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
            let searchResult = try await service.getSearchResult(from: fromCode, to: toCode, on: date, transportType: "train", transfers: hasTransfers)
            carriersList = searchResult.segments ?? []
            filteredCarriersList = carriersList
        } catch ErrorsType.internetConnectError {
            addPath(with: Route.noInternetView)
        } catch ErrorsType.serverError {
            addPath(with: Route.serverErrorView)
        } catch {
            addPath(with: Route.serverErrorView)
            print(String(describing: error))
        }
        
        isLoading = false
    }
    
    func setFilters() {
        var filteredCarriers = carriersList
        
        if !departureTimeIntervals.isEmpty {
            filteredCarriers = filteredCarriers.filter { segment in
                let time = departureTime(departure: segment.departure ?? "")
                    switch time {
                    case 6...12:
                        return departureTimeIntervals.contains(.morning)
                    case 12...18:
                        return departureTimeIntervals.contains(.afternoon)
                    case 18...23:
                        return departureTimeIntervals.contains(.evening)
                    case 0...6:
                        return departureTimeIntervals.contains(.night)
                    default:
                        return false
                    }
                }
        }
        
        if !hasTransfers {
            filteredCarriers = filteredCarriers.filter {$0.has_transfers == false }
        }
        
        filteredCarriersList = filteredCarriers
    }
    
    func setSearchButtonEnable() -> Bool {
        return fromStation != nil && toStation != nil 
    }
    
    func addPath(with route: Route) {
        navigationService.push(route: route)
    }
    
    func backToRoot() {
        navigationService.popRoot()
    }
    
    func popLast() {
        navigationService.popLast()
    }
    
    // MARK: - Private Methods
    
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
            addPath(with: Route.serverErrorView)
            print(String(describing: error))
        }
        
        allSettlements = stationList.filter { $0.title != ""}
        isLoading = allSettlements.isEmpty ? true : false
        allSettlements.sort {$0.title! < $1.title! }
    }
    
    private func departureTime(departure: String) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let hour = Calendar.current.component(.hour, from: dateFormatter.date(from: departure) ?? Date())
        return hour
    }
    
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
