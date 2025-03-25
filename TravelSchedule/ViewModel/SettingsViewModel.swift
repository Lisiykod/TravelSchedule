//
//  SettingsViewModel.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 22.03.2025.
//

import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
    @Published var isDarkModeOn: Bool = false {
        didSet {
            UserDefaults.standard.set(isDarkModeOn, forKey: Constants.appThemeKey)
        }
    }
    
    init() {
        isDarkModeOn = UserDefaults.standard.bool(forKey: Constants.appThemeKey)
    }
    
    func toggleAppTheme() {
        isDarkModeOn.toggle()
    }
}
