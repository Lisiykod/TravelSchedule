//
//  SelectStationView.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 22.02.2025.
//

import SwiftUI

struct SelectStationView: View {
    
    @EnvironmentObject private var viewModel: ScheduleViewModel
    @State private var searchString: String = ""
    @Binding var path: [String]
    
    var searchResults: [Stations] {
        if searchString.isEmpty {
            return viewModel.stations
        } else {
            return viewModel.stations.filter {
                $0.title?.contains(searchString.lowercased()) ?? false
            }
        }
    }
    
    var body: some View {
        VStack {
            SearchBar(searchText: $searchString)
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(viewModel.stations, id: \.self) { station in
                        ListRowView(settlement: station.title ?? "")
                        .background()
                        .onTapGesture {
                            path = []
                        }
                    }
                }
                .padding([.leading,. trailing], 16)
            }
            .navigationTitle("Выбор станции")
            .toolbarRole(.editor)
            Spacer()
        }
    }
}

#Preview {
    SelectStationView(path: .constant([""]))
        .environmentObject(ScheduleViewModel())
}
