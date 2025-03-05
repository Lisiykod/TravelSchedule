//
//  NotFoundView.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 25.02.2025.
//

import SwiftUI

struct NotFoundView: View {
    let text: String
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea(.all)
            Text(text)
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.ypBlack)
        }
    }
}

#Preview {
    NotFoundView(text: "Город не найден")
}
