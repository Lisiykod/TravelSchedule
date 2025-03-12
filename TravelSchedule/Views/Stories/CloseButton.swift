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
            Image(systemName: "xmark.circle.fill")
                .imageScale(.large)
                .frame(width: 30, height: 30)
                .foregroundStyle(.ypBlackUniversal)
        }
    }
}

#Preview {
    CloseButton(action: {print("tap tap")})
}
