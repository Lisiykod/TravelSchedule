//
//  CarrierCardView.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 25.02.2025.
//

import SwiftUI

struct CarrierCardView: View {
    let imageName: String
    let hasTransfer: Bool
    let carrierName: String
    let transferString: String?
    let date: String
    let beginTime: String
    let endTime: String
    let travelTime: String
    
    var body: some View {
        ZStack {
            Color.ypLightGray
            VStack(spacing: 14) {
                HStack(alignment: .top, spacing: 18) {
                    Image(imageName)
                        .frame(width: 38, height: 38)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    VStack(alignment: .leading) {
                        Text(carrierName)
                            .font(.system(size: 17, weight: .regular))
                        if hasTransfer {
                            Text(transferString ?? "")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundStyle(.ypRedUniversal)
                        }
                    }
                    Spacer()
                    Text(date)
                        .font(.system(size: 12, weight: .regular))
                }
                
                HStack {
                    Text(beginTime)
                    separator
                    Text("\(travelTime) часов")
                        .font(.system(size: 12, weight: .regular))
                    separator
                    Text(endTime)
                }
            }
            .padding([.leading, .trailing], 16)
            .padding([.top, .bottom], 14)
        }
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
    
    @ViewBuilder
    var separator: some View {
        Rectangle()
            .foregroundStyle(.ypGrayUniversal)
            .frame(height: 1)
    }
}

#Preview {
    CarrierCardView(imageName: "mockIcon", hasTransfer: true, carrierName: "РЖД", transferString: "true", date: "24 января", beginTime: "11:40", endTime: "20:10", travelTime: "9")
}
