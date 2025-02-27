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
        VStack {
            AsyncImage(url: URL(string: viewModel.carrier?.logo ?? "")) { phase in
                switch phase {
                case .failure:
                    Image(systemName: "photo")
                        .font(.largeTitle)
                case .success(let image):
                    image
                        .resizable()
                default:
                    ProgressView()
                }
            }
            .frame(width: 343, height: 104)
            .clipShape(.rect(cornerRadius: 24))
            
            VStack {
                Text(viewModel.carrier?.title ?? "")
                    .font(.system(size: 24, weight: .bold))
                VStack(spacing: 0) {
                    Text("E-mail")
                        .font(.system(size: 17, weight: .regular))
                    Text(viewModel.carrier?.email ?? "")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(.ypBlueUniversal)
                }
                
                VStack(spacing: 0) {
                    Text("Телефон")
                        .font(.system(size: 17, weight: .regular))
                    Text(viewModel.carrier?.phone ?? "")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(.ypBlueUniversal)
                }
            }
        }
        .padding(16)
    }
    
}

#Preview {
    CarrierInfoView()
        .environmentObject(ScheduleViewModel())
}
