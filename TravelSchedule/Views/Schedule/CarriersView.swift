//
//  CarriersView.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 22.02.2025.
//

import SwiftUI

struct CarriersView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .font(.system(size: 24, weight: .bold))
            ScrollView {
                LazyVStack(spacing: 8) {
                    CarrierCardView(imageName: "mockIcon", hasTransfer: true, carrierName: "РЖД", transferString: "true", date: "24 января", beginTime: "11:40", endTime: "20:10", travelTime: "9")
                        .frame(height: 104)
                        .padding(16)
                }
            }
            Spacer()
        }
    }
}

#Preview {
    CarriersView()
}
