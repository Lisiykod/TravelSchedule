//
//  NotFoundView.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 25.02.2025.
//

import SwiftUI

struct NotFoundView: View {
    let filter: Bool
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea(.all)
            Text(filter ? "Вариантов нет" : "Город не найден")
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.ypBlack)
        }
    }
}

#Preview {
    NotFoundView(filter: false)
}
