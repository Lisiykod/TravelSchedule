//
//  CarrierCardView.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 25.02.2025.
//

import SwiftUI

struct CarrierCardView: View {
    
    private let segment: Segments
    private let startDate: String
    private let departureTime: String
    private let arrivalTime: String
    private let travelTime: Double
    
    init(segmentInfo: Segments, startDate: String, departureTime: String, arrivalTime: String) {
        self.segment = segmentInfo
        travelTime = (segment.duration ?? 0)/3600
        
        self.startDate = startDate
        self.departureTime = departureTime
        self.arrivalTime = arrivalTime
    }
    
    var body: some View {
        ZStack {
            Color.ypLightGray
            VStack(spacing: 14) {
                HStack(alignment: .top, spacing: 18) {
                    AsyncImage(url: URL(string: segment.thread?.carrier?.logo ?? "")) { phase in
                        switch phase {
                        case .failure:
                            Image(systemName: "photo")
                                .font(.largeTitle)
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(1, contentMode: .fill)
                        default:
                            ProgressView()
                        }
                    }
                    .frame(width: 38, height: 38)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    VStack(alignment: .leading) {
                        Text(segment.thread?.carrier?.title ?? "информации нет")
                            .font(.system(size: 17, weight: .regular))
                        Text("C пересадкой в: \(segment.transfers?.first?.title ?? "")")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(.ypRedUniversal)
                            .lineLimit(2)
                            .opacity( segment.has_transfers ?? false ? 1 : 0)
                    }
                    Spacer()
                    Text(startDate)
                        .font(.system(size: 12, weight: .regular))
                }
                .foregroundStyle(.ypBlackUniversal)
                
                HStack {
                    Text(departureTime)
                    separator
                    Text("\(travelTime, specifier: "%.0f") часов")
                        .font(.system(size: 12, weight: .regular))
                    separator
                    Text(arrivalTime)
                }
                .foregroundStyle(.ypBlackUniversal)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
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
    CarrierCardView(segmentInfo: Segments(), startDate: "", departureTime: "", arrivalTime: "")
}
