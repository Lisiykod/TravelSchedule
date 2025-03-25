//
//  CarriersView.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 22.02.2025.
//

import SwiftUI

struct CarriersView: View {
    
    @ObservedObject var carriersVM: CarriersViewModel
    @ObservedObject var filtersVM: FiltersViewModel
    @EnvironmentObject private var viewModel: ScheduleViewModel
    @EnvironmentObject private var navigationService: Router
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            VStack(spacing: 16) {
                Group {
                    Text("\(viewModel.fromSettlement?.title ?? "")" + " (\(viewModel.fromStation?.title ?? "")) ") +
                    Text(" -> ") +
                    Text("\(viewModel.toSettlement?.title ?? "")" + " (\(viewModel.toStation?.title ?? "")) ")
                }
                .font(.system(size: 24, weight: .bold))
                
                if viewModel.isLoading {
                    Spacer()
                    ProgressView()
                } else if !carriersVM.filteredCarriersList.isEmpty {
                    ZStack(alignment: .bottom) {
                        ScrollView {
                            LazyVStack(spacing: 8) {
                                ForEach(carriersVM.filteredCarriersList, id: \.self) { segment in
                                    CarrierCardView(
                                        segmentInfo: segment,
                                        startDate: carriersVM.dateFormatter(date: segment.start_date ?? "", with: "dd MMMM", locale: "Ru_ru"),
                                        departureTime: carriersVM.dateFormatter(date: segment.departure ?? "", with: "HH:mm", locale: "Ru_ru"),
                                        arrivalTime: carriersVM.dateFormatter(date: segment.arrival ?? "", with: "HH:mm", locale: "Ru_ru")
                                    )
                                        .frame(height: 104)
                                        .onTapGesture {
                                            carriersVM.carrier = segment.thread?.carrier
                                            navigationService.push(route: Route.selectCarrierInfoView)
                                        }
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                        
                        VStack {
                            Spacer()
                            
                            Button {
                                filtersVM.departureTimeIntervals.removeAll()
                                navigationService.push(route: Route.filtersView)
                            } label: {
                                Label {
                                    HStack {
                                        Text("Уточнить время")
                                            .font(.system(size: 17, weight: .bold))
                                            .foregroundStyle(.ypWhiteUniversal)
                                        Circle()
                                            .frame(width: 8, height: 8)
                                            .foregroundStyle(filtersVM.isFilter ? .ypRedUniversal : .ypBlue)
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
        }
    }
}

#Preview {
    CarriersView(carriersVM: CarriersViewModel(), filtersVM: FiltersViewModel())
        .environmentObject(ScheduleViewModel())
}
