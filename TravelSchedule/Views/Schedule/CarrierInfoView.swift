//
//  CarrierInfoView.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 22.02.2025.
//

import SwiftUI

struct CarrierInfoView: View {
    @EnvironmentObject private var viewModel: ScheduleViewModel
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea(.all)
            VStack(alignment: .leading) {
                VStack(alignment: .center) {
                    AsyncImage(url: URL(string: viewModel.carrier?.logo ?? "")) { phase in
                        switch phase {
                        case .failure:
                            Image(systemName: "photo")
                                .font(.largeTitle)
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        default:
                            Image(systemName: "photo")
                                .font(.largeTitle)
                        }
                    }
                    .frame(width: 343, height: 104)
                    .clipShape(.rect(cornerRadius: 24))
                }
                
                
                VStack(alignment: .leading, spacing: 16) {
                    Text(viewModel.carrier?.title ?? "информации нет")
                        .font(.system(size: 24, weight: .bold))
                    VStack(alignment: .leading, spacing: 0) {
                        Text("E-mail")
                            .font(.system(size: 17, weight: .regular))
                        Text(viewModel.carrier?.email ?? "информации нет")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(.ypBlueUniversal)
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Телефон")
                            .font(.system(size: 17, weight: .regular))
                        Text(viewModel.carrier?.phone ?? "информации нет")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(.ypBlueUniversal)
                    }
                }
                Spacer()
                    .toolbarRole(.editor)
                    .navigationTitle("Информация о перевозчике")
            }
            .foregroundStyle(.ypBlack)
            .padding(16)
        }
    }
    
}

#Preview {
    CarrierInfoView()
        .environmentObject(ScheduleViewModel())
}
