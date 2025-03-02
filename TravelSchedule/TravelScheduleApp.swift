//
//  TravelScheduleApp.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 07.02.2025.
//

import SwiftUI

@main
struct TravelScheduleApp: App {
    
    @State private var viewModel = ScheduleViewModel()
    @AppStorage("appTheme") private var isDarkModeOn = false
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(viewModel)
                .preferredColorScheme(isDarkModeOn ? .dark : .light)
        }
    }
}
