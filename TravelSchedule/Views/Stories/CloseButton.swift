//
//  CloseButton.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 12.03.2025.
//

import SwiftUI

struct CloseButton: View {
    
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle().foregroundStyle(.ypWhiteUniversal)
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .foregroundStyle(.ypBlackUniversal)
            }
            .frame(width: 30, height: 30)
        }
    }
}

#Preview {
    CloseButton(action: {print("tap tap")})
}
