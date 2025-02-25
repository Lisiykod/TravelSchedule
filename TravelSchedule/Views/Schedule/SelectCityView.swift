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
            SearchBar(searchText: $searchString)
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(viewModel.allSettlements, id: \.self) { settlement in
                        ListRowView(settlement: settlement.title ?? "")
                        .background()
                        .onTapGesture {
                            path.append("SelectStationView")
                            viewModel.setSettlementsStations(on: settlement)
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
    SelectCityView(path: .constant([""]))
        .environmentObject(ScheduleViewModel())
}
