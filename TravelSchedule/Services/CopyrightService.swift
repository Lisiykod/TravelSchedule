//
//  CopyrightService.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 10.02.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias Copyright = Components.Schemas.CopyrightInfo

protocol CopyrightServiceProtocol {
    func getCopyrigth() async throws -> Copyright
}

final class CopyrightService: CopyrightServiceProtocol {
    private let client: Client
    private let apiKey: String
    
    init(client: Client, apiKey: String) {
        self.client = client
        self.apiKey = apiKey
    }
    
    func getCopyrigth() async throws -> Copyright {
        let responce = try await client.getCopyright(
            query: .init(
                apikey: apiKey,
                format: "json"
            )
        )
        
        return try responce.ok.body.json
    }
    
}
