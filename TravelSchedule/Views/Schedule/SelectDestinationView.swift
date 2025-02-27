//
//  SelectDestinationView.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 23.02.2025.
//

import SwiftUI

struct SelectDestinationView: View {
    let text: String
    let placeholder: String
    
    init(text: String, placeholder: String) {
        if text == "()".trimmingCharacters(in: .whitespacesAndNewlines) {
            self.text = placeholder
        } else {
            self.text = text
        }
        self.placeholder = placeholder
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color.ypWhiteUniversal
            Text(text)
                .padding([.top, .bottom], 14)
                .padding([.leading], 16)
                .lineLimit(1)
                .foregroundStyle(text != placeholder ? .ypBlack : .ypGray)
        }
        .cornerRadius(20)
    }
}

#Preview {
    SelectDestinationView(text: "", placeholder: "Откуда")
}
