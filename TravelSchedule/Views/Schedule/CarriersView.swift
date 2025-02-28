//
//  CarriersView.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 22.02.2025.
//

import SwiftUI

struct CarriersView: View {
    
    @EnvironmentObject private var viewModel: ScheduleViewModel

    var body: some View {
        VStack() {
            Group {
                Text("\(viewModel.fromSettlemet?.title ?? "")" + " (\(viewModel.fromStation?.title ?? "")) ") +
                Text(" -> ") +
                Text("\(viewModel.toSettlemet?.title ?? "")" + " (\(viewModel.toStation?.title ?? "")) ")
            }
            .font(.system(size: 24, weight: .bold))
            
            if viewModel.isLoading {
                Spacer()
                ProgressView()
            } else if !viewModel.carriersList.isEmpty {
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(viewModel.carriersList, id: \.self) { segment in
                            CarrierCardView(segmentInfo: segment)
                                .frame(height: 104)
//                                .padding(16)
                                .onTapGesture {
                                    viewModel.carrier = segment.thread?.carrier
                                    viewModel.addPath(with: Route.selectCarrierInfoView)
                                }
                        }
                    }
                }
            } else {
                Spacer()
                NotFoundView(filter: true)
            }
            Spacer()
                .toolbarRole(.editor)
        }
        .padding(16)
    }
}

#Preview {
    CarriersView()
        .environmentObject(ScheduleViewModel())
}
