//
//  SelectCityView.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 22.02.2025.
//

import SwiftUI

struct SelectCityView: View {
    
    @EnvironmentObject private var viewModel: ScheduleViewModel
    @State private var searchString: String = ""
    private var direction: Direction
    
    init(direction: Direction) {
        self.direction = direction
    }
    
    var searchResults: [Settlements] {
        if searchString.isEmpty {
            return viewModel.allSettlements
        } else {
            return viewModel.allSettlements.filter {
                $0.title?.contains(searchString.capitalized) ?? false
            }
        }
    }
    
    var body: some View {
        VStack {
            SearchBar(searchText: $searchString)
            
            if viewModel.isLoading {
                Spacer()
                ProgressView()
            } else if !viewModel.allSettlements.isEmpty {
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        ForEach(searchResults, id: \.self) { settlement in
                            ListRowView(settlement: settlement.title ?? "")
                                .background()
                                .onTapGesture {
                                    switch direction {
                                    case .from:
                                        viewModel.addPath(with: Route.selectFromStationView)
                                    case .to:
                                        viewModel.addPath(with: Route.selectToStationView)
                                    }
                                    viewModel.setSettlementsStations(on: settlement, direction: direction)
                                }
                        }
                    }
                    .padding([.leading,. trailing], 16)
                }
            } else if searchResults.isEmpty {
                Spacer()
                NotFoundView(filter: false)
            }
            Spacer()
                .navigationTitle("Выбор города")
                .toolbarRole(.editor)
        }
    }
}


#Preview {
    SelectCityView(direction: .from)
        .environmentObject(ScheduleViewModel())
}
