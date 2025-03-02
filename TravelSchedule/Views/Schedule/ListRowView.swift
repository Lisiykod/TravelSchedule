//
//  ListRowView.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 25.02.2025.
//

import SwiftUI

struct ListRowView: View {
    
    var settlement: String
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea(.all)
            HStack {
                Text(settlement)
                    .font(.system(size: 17, weight: .regular))
                    .padding([.top, .bottom], 19)
                Spacer()
                Image("Chevron")
            }
        }
    }
}

#Preview {
    ListRowView(settlement: "Москва")
}
