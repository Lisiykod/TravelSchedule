//
//  ContentView.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 07.02.2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var path: [String] = []
    
    var body: some View {
        
        NavigationStack(path: $path) {
            TabView {
                ScheduleView()
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
                default:
                    UserAgreementView()
                }
            }
        }
        .tint(.ypBlack)
    
    }
    
}

#Preview {
    ContentView()
}
