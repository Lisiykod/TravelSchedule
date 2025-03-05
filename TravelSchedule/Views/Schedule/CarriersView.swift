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
        ZStack {
            Color.ypWhite.ignoresSafeArea(.all)
            VStack(spacing: 16) {
                Group {
                    Text("\(viewModel.fromSettlemet?.title ?? "")" + " (\(viewModel.fromStation?.title ?? "")) ") +
                    Text(" -> ") +
                    Text("\(viewModel.toSettlemet?.title ?? "")" + " (\(viewModel.toStation?.title ?? "")) ")
                }
                .font(.system(size: 24, weight: .bold))
                
                if viewModel.isLoading {
                    Spacer()
                    ProgressView()
                } else if !viewModel.filteredCarriersList.isEmpty {
                    ZStack(alignment: .bottom) {
                        ScrollView {
                            LazyVStack(spacing: 8) {
                                ForEach(viewModel.filteredCarriersList, id: \.self) { segment in
                                    CarrierCardView(segmentInfo: segment)
                                        .frame(height: 104)
                                        .onTapGesture {
                                            viewModel.carrier = segment.thread?.carrier
                                            viewModel.addPath(with: Route.selectCarrierInfoView)
                                        }
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                        
                        VStack {
                            Spacer()
                            
                            Button {
                                viewModel.departureTimeIntervals.removeAll()
                                viewModel.addPath(with: Route.filtersView)
                            } label: {
                                Label {
                                    HStack {
                                        Text("Уточнить время")
                                            .font(.system(size: 17, weight: .bold))
                                            .foregroundStyle(.ypWhiteUniversal)
                                        Circle()
                                            .frame(width: 8, height: 8)
                                            .foregroundStyle(viewModel.isFilter ? .ypRedUniversal : .ypBlue)
                                    }
                                } icon: {}
                                
                            }
                            .frame(idealWidth: 343, maxWidth: .infinity, maxHeight: 60)
                            .background(.ypBlue)
                            .clipShape(.rect(cornerRadius: 16))
                            .padding(.bottom, 8)
                        }
                    }
                } else {
                    Spacer()
                    NotFoundView(text: "Вариантов нет")
                }
                Spacer()
                    .toolbarRole(.editor)
            }
            .foregroundStyle(.ypBlack)
            .padding(16)
            
        } //ZStack
    }
}

#Preview {
    CarriersView()
        .environmentObject(ScheduleViewModel())
}
