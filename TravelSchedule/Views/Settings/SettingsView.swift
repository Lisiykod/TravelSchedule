//
//  SettingsView.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 18.02.2025.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var isDarkModeOn = false
    @Binding var path: [String]
    
    var body: some View {
            VStack {
                Toggle("Темная тема", isOn: $isDarkModeOn)
                    .toggleStyle(SwitchToggleStyle(tint: .ypBlue))
                    .frame(height: 60)
                
                    HStack() {
                        Text("Пользовательское соглашение")
                        Spacer()
                        Image("Chevron")
                    }
                    .background()
                    .frame(height: 60)
                    .onTapGesture {
                        path.append("UserAgreementView")
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

#Preview {
    SettingsView(path: .constant([""]))
}
