//
//  SettingsView.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 18.02.2025.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject private var viewModel: ScheduleViewModel
    @EnvironmentObject private var navigationService: Router
    @AppStorage(Constants.appThemeKey) private var isDarkModeOn = false
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            
            VStack {
                Toggle("Темная тема", isOn: $isDarkModeOn)
                    .toggleStyle(SwitchToggleStyle(tint: .ypBlue))
                    .frame(height: 60)
                
                HStack() {
                    Text("Пользовательское соглашение")
                    Spacer()
                    Image("Chevron")
                }
                .foregroundStyle(.ypBlack)
                .background(.ypWhite)
                .frame(height: 60)
                .onTapGesture {
                    navigationService.push(route: Route.userAgreementView)
                }
                
                Spacer()
                
                VStack(spacing: 12) {
                    Text("Приложение использует API «Яндекс.Расписания»")
                    Text("Версия 1.0 (beta)")
                }
                .foregroundStyle(.ypBlack)
                .font(.system(size: 12, weight: .regular))
            }
            .foregroundStyle(.ypBlack)
            .padding(16)
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(ScheduleViewModel())
}
