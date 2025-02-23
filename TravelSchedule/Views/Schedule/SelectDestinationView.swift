//
//  SelectDestinationView.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 23.02.2025.
//

import SwiftUI

struct SelectDestinationView: View {
    let text: String?
    let placeholder: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color.ypWhiteUniversal
            Text(text ?? placeholder)
                .padding([.top, .bottom], 14)
                .padding([.leading], 16)
                .lineLimit(1)
                .foregroundStyle(text != nil ? .ypBlack : .ypGray)
        }
        .cornerRadius(20)
    }
}

#Preview {
    SelectDestinationView(text: nil, placeholder: "Откуда")
}
