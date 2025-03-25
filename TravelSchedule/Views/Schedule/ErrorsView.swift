//
//  ErrorsView.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 22.02.2025.
//

import SwiftUI

struct ErrorsView: View {
    let imageName: String
    let text: String
    
    init(error: ErrorsType) {
        switch error {
        case .internetConnectError:
            self.imageName = "noInternet"
            self.text = "Нет интернета"
        case .serverError:
            self.imageName = "serverError"
            self.text = "Ошибка сервера"
        case .unknownError:
            self.imageName = "serverError"
            self.text = "Неизвестная ошибка"
        }
    }
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            VStack(alignment: .center, spacing: 16) {
                Image(imageName)
                Text(text)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.ypBlack)
            }
        }
    }
}

#Preview {
    ErrorsView(error: .internetConnectError)
}
