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
    @Binding var path: [String]
    private var direction: Direction
    
    init(direction: Direction, path: Binding<[String]>) {
        self.direction = direction
        self._path = path
    }
    
    var searchResults: [Settlements] {
        if searchString.isEmpty {
            return viewModel.allSettlements
        } else {
            return viewModel.allSettlements.filter {
                $0.title?.contains(searchString.lowercased()) ?? false
            }
        }
    }
    
    var body: some View {
        VStack {
            ProgressView()
            SearchBar(searchText: $searchString)
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(viewModel.allSettlements, id: \.self) { settlement in
                        ListRowView(settlement: settlement.title ?? "")
                            .background()
                            .onTapGesture {
                                switch direction {
                                case .from:
                                    path.append(NavigationConstants.selectFromStationView.rawValue)
                                case .to:
                                    path.append(NavigationConstants.selectToStationView.rawValue)
                                }
                                viewModel.setSettlementsStations(on: settlement, direction: direction)
                            }
                    }
                }
                .padding([.leading,. trailing], 16)
            }
            .navigationTitle("Выбор города")
            .toolbarRole(.editor)
            Spacer()
        }
    }
}


#Preview {
    SelectCityView(direction: .from, path: .constant([""]))
        .environmentObject(ScheduleViewModel())
}
