//
//  TravelScheduleApp.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 07.02.2025.
//

import SwiftUI

@main
struct TravelScheduleApp: App {
    
    @StateObject private var viewModel = ScheduleViewModel()
    @StateObject private var navigationService = Router()
    @StateObject private var settingsVM = SettingsViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(viewModel)
                .environmentObject(navigationService)
                .environmentObject(settingsVM)
                .preferredColorScheme(settingsVM.isDarkModeOn ? .dark : .light)
        }
    }
}
