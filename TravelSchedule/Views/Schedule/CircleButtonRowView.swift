//
//  CircleButtonRowView.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 01.03.2025.
//

import SwiftUI

struct CircleButtonRowView: View {
    
    let hasTransfer: Bool
    @Binding var selectTransfer: Bool
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea(.all)
            HStack {
                Text(hasTransfer ? "Да" : "Нет")
                Spacer()
                Image(systemName: selectTransfer == hasTransfer ? "largecircle.fill.circle" : "circle")
                    .onTapGesture {
                        selectTransfer = hasTransfer
                    }
            }
            .foregroundStyle(.ypBlack)
        }
        .frame(height: 60)
    }
}

#Preview {
    CircleButtonRowView(hasTransfer: true, selectTransfer: .constant(true))
}
