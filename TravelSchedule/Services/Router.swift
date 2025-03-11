//
//  NavigationService.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 27.02.2025.
//

import Foundation

final class Router: ObservableObject {
    
    @Published var path: [Route] = []
    
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
