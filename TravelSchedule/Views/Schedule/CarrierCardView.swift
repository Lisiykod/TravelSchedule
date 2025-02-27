//
//  CarrierCardView.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 25.02.2025.
//

import SwiftUI

struct CarrierCardView: View {
    
    private let segment: Segments
    private let startDateString: String
    private let beginTime: String
    private let endTime: String
    private let travelTime: Double
    
    init(segmentInfo: Segments) {
        self.segment = segmentInfo
        travelTime = (segment.duration ?? 0)/3600
        
        let generalFormatter = DateFormatter()
        generalFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let startDateFormatter = DateFormatter()
        startDateFormatter.dateFormat = "MM-DD"
        
        let beginTimeFormatter = DateFormatter()
        beginTimeFormatter.dateFormat = "hh:mm"
        
        let endTimeFormatter = DateFormatter()
        endTimeFormatter.dateFormat = "hh:mm"
        let currentDate = Date()
        
        startDateString = startDateFormatter.string(from: generalFormatter.date(from: segmentInfo.thread?.start_date ?? "") ?? currentDate)
        beginTime = beginTimeFormatter.string(from: generalFormatter.date(from: segmentInfo.thread?.departure_date ?? "") ?? currentDate)
        endTime = endTimeFormatter.string(from: generalFormatter.date(from: segmentInfo.thread?.arrival_date ?? "") ?? currentDate)
    }
    
    var body: some View {
        ZStack {
            Color.ypLightGray
            VStack(spacing: 14) {
                HStack(alignment: .top, spacing: 18) {
                    Image(segment.thread?.carrier?.logo ?? "emptyBrandIcon")
                        .frame(width: 38, height: 38)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    VStack(alignment: .leading) {
                        Text(segment.thread?.carrier?.title ?? "")
                            .font(.system(size: 17, weight: .regular))
                        if segment.has_transfers ?? false {
                            Text("Пересадка в \(segment.transfers ?? "")")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundStyle(.ypRedUniversal)
                        }
                    }
                    Spacer()
                    Text(startDateString)
                        .font(.system(size: 12, weight: .regular))
                }
                
                HStack {
                    Text(beginTime)
                    separator
                    Text("\(travelTime, specifier: "%.0f") часов")
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
    CarrierCardView(segmentInfo: Segments())
}
