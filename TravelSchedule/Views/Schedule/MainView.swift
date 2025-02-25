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
                case NavigationConstants.selectCityView.rawValue:
                    SelectCityView(path: $path)
                case NavigationConstants.selectStationView.rawValue:
                    SelectStationView(path: $path)
                default:
                    UserAgreementView()
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
