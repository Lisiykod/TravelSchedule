//
//  NavigationService.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 27.02.2025.
//

import Foundation

final class Router: ObservableObject {
    
    static let shared = Router()
    
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
