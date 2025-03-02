//
//  FiltersView.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 22.02.2025.
//

import SwiftUI

struct FiltersView: View {
    @EnvironmentObject private var viewModel: ScheduleViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading) {
                Text("Время отправления")
                    .font(.system(size: 24, weight: .bold))
                DepartureTimeIntervalView(departureTimeInterval: $viewModel.departureTimeIntervals, selectedTimeInterval: .morning)
                DepartureTimeIntervalView(departureTimeInterval: $viewModel.departureTimeIntervals, selectedTimeInterval: .afternoon)
                DepartureTimeIntervalView(departureTimeInterval: $viewModel.departureTimeIntervals, selectedTimeInterval: .evening)
                DepartureTimeIntervalView(departureTimeInterval: $viewModel.departureTimeIntervals, selectedTimeInterval: .night)
                
            }
            
            VStack(alignment: .leading) {
                Text("Показывать варианты с пересадками")
                    .font(.system(size: 24, weight: .bold))
                CircleButtonRowView(hasTransfer: true, selectTransfer: $viewModel.hasTransfers)
                CircleButtonRowView(hasTransfer: false, selectTransfer: $viewModel.hasTransfers)
                
            }
            
            Spacer()
            
            Button {
                viewModel.setFilters()
                viewModel.isFilter = !viewModel.departureTimeIntervals.isEmpty || !viewModel.hasTransfers ? true : false
                viewModel.popLast()
            } label: {
                Label {
                    HStack {
                        Text("Применить")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundStyle(.ypWhiteUniversal)
                    }
                } icon: {}
                    .padding()
                
            }
            .frame(idealWidth: 343, maxWidth: .infinity, maxHeight: 60)
            .background(.ypBlue)
            .clipShape(.rect(cornerRadius: 16))
            .padding(.bottom, 24)
            .toolbarRole(.editor)
        }
        .padding(16)
    }
}

#Preview {
    FiltersView()
        .environmentObject(ScheduleViewModel())
}
