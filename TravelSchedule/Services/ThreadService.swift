//
//  ThreadService.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 10.02.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias Thread = Components.Schemas.Thread

protocol ThreadServiceProtocol {
    func getThread(uid: String) async throws -> Thread
}

final class ThreadService: ThreadServiceProtocol {
    private let client: Client
    private let apiKey: String
    
    init(client: Client, apiKey: String) {
        self.client = client
        self.apiKey = apiKey
    }
    
    func getThread(uid: String) async throws -> Thread {
        let response = try await client.getThread(
            query: .init(
                apikey: Constants.apiKey,
                uid: uid
            )
        )
        return try response.ok.body.json
    }
}
