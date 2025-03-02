//
//  DepartureTimeIntervalView.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 01.03.2025.
//

import SwiftUI

struct DepartureTimeIntervalView: View {
    
    @Binding var departureTimeInterval: [DepartureTimeInterval]
    @State private var selectCheckBox: Bool = false
    var selectedTimeInterval: DepartureTimeInterval
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea(.all)
            HStack {
                Text(selectedTimeInterval.rawValue)
                Spacer()
                Image(systemName: selectCheckBox ? "checkmark.square.fill" : "square")
                    .frame(width: 20, height: 20)
                    .onTapGesture {
                        if !departureTimeInterval.contains(selectedTimeInterval) {
                            departureTimeInterval.append(selectedTimeInterval)
                            selectCheckBox = true
                        } else {
                            departureTimeInterval = departureTimeInterval.filter { $0 != selectedTimeInterval}
                            selectCheckBox = false
                        }
                    }
            }
            .foregroundStyle(.ypBlack)
            .padding([.top, .bottom], 19)
        }
    }
}

#Preview {
    DepartureTimeIntervalView(departureTimeInterval: .constant([.afternoon]), selectedTimeInterval: .afternoon)
}
