//
//  CarrierInfoService.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 09.02.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias CarrierInfo = Components.Schemas.Carriers

protocol CarrierInfoServiceProtocol {
    func getCarrierInfo(code: String) async throws -> CarrierInfo
}

final class CarrierInfoService: CarrierInfoServiceProtocol {
    private let client: Client
    private let apiKey: String
    
    init(client: Client, apiKey: String) {
        self.client = client
        self.apiKey = apiKey
    }
    
    func getCarrierInfo(code: String) async throws -> CarrierInfo {
        let responce = try await client.getCarrierInfo(query: .init(apikey: apiKey, code: code))
        return try responce.ok.body.json
    }
}
