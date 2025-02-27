//
//  MainView.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 07.02.2025.
//

import SwiftUI

struct MainView: View {
    
    @State private var path: [String] = []
    
    var body: some View {
        
        NavigationStack(path: $path) {
            TabView {
                ScheduleView(path: $path)
                    .tabItem {
                        Image("arrowUpIcon")
                            .renderingMode(.template)
                    }
                
                SettingsView(path: $path)
                    .tabItem {
                        Image("SettingsIcon")
                            .renderingMode(.template)
                    }
            }
            .navigationDestination(for: String.self) { destinationID in
                switch destinationID {
                case NavigationConstants.userAgreementView.rawValue:
                    UserAgreementView()
                case NavigationConstants.selectFromCityView.rawValue:
                    SelectCityView(direction: .from, path: $path)
                case NavigationConstants.selectFromStationView.rawValue:
                    SelectStationView(direction: .from, path: $path)
                case NavigationConstants.selectToCityView.rawValue:
                    SelectCityView(direction: .to, path: $path)
                case NavigationConstants.selectToStationView.rawValue:
                    SelectStationView(direction: .to, path: $path)
                case NavigationConstants.carriersView.rawValue:
                    CarriersView(path: $path)
                case NavigationConstants.noInternetView.rawValue:
                    ErrorsView(error: .internetConnectError)
                case NavigationConstants.serverErrorView.rawValue:
                    ErrorsView(error: .serverError)
                default:
                    ErrorsView(error: .internetConnectError)
                }
            }
        }
        .tint(.ypBlack)
    
    }
    
}

#Preview {
    MainView()
        .environmentObject(ScheduleViewModel())
}
