//
//  NavigationService.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 27.02.2025.
//

import Foundation

class NavigationService: ObservableObject {
    
    static let shared = NavigationService()
    
    @Published var path: [Route] = []
    
    private init() {}
    
    func push(route: Route) {
        path.append(route)
    }
    
    func popRoot() {
        path.removeAll()
    }
    
    func popLast() {
        path.removeLast()
    }
}
