//
//  CarriersView.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 22.02.2025.
//

import SwiftUI

struct CarriersView: View {
    
    @EnvironmentObject private var viewModel: ScheduleViewModel
    @Binding var path: [String]
    
    var body: some View {
        VStack(spacing: 16) {
            Group {
                Text("\(viewModel.fromSettlemet?.title ?? "")" + " (\(viewModel.fromStation?.title ?? "")) ") +
                Text(" -> ") +
                Text("\(viewModel.toSettlemet?.title ?? "")" + " (\(viewModel.toStation?.title ?? "")) ")
            }
            .font(.system(size: 24, weight: .bold))
            
            if viewModel.carriersList.isEmpty {
                Spacer()
                NotFoundView(filter: true)
            } else {
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(viewModel.carriersList, id: \.self) { segment in
                            CarrierCardView(segmentInfo: segment)
                                .frame(height: 104)
                                .padding(16)
                                .onTapGesture {
                                    viewModel.carrier = segment.thread?.carrier
                                    path.append(NavigationConstants.selectCarrierInfoView.rawValue)
                                }
                        }
                    }
                }
                .toolbarRole(.editor)
            }
            
            Spacer()
        }
        .padding(16)
    }
}

#Preview {
    CarriersView(path: .constant([""]))
        .environmentObject(ScheduleViewModel())
}
