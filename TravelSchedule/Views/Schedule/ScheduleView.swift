//
//  ScheduleView.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 18.02.2025.
//

import SwiftUI

struct ScheduleView: View {
    
    @EnvironmentObject private var viewModel: ScheduleViewModel
    @Binding var path: [String]
    
    var body: some View {
            VStack(spacing: 16) {
                ZStack {
                    Color.ypBlue
                    HStack(spacing: 16) {
                        VStack(alignment: .leading) { 
                            SelectDestinationView(
                                text:"\(viewModel.fromSettlemet?.title ?? "") (\(viewModel.fromStation?.title ?? ""))",
                                placeholder: "Откуда"
                            )
                                .onTapGesture {
                                    path.append(NavigationConstants.selectFromCityView.rawValue)
                                }
                            SelectDestinationView(
                                text:"\(viewModel.toSettlemet?.title ?? "") (\(viewModel.toStation?.title ?? ""))",
                                placeholder: "Куда"
                            )
                            .onTapGesture {
                                path.append(NavigationConstants.selectToCityView.rawValue)
                            }
                        }
                        .frame(height: 96)
                        .font(.system(size: 17, weight: .regular))
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(.white)
                        )
                        
                        Button {
                            viewModel.changeDirection()
                        } label: {
                            Image("change")
                                .frame(width: 36, height: 36)
                                .background(.white)
                                .cornerRadius(40)
                        }

                    } // HStack
                    .padding(16)
                } // ZStack
                .cornerRadius(20)
                .padding([.leading, .trailing], 16)
                .frame(height: 128)
                
                Button {
                    viewModel.search()
                    path.append(NavigationConstants.carriersView.rawValue)
                } label: {
                    Text("Найти")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(width: 150, height: 60)
                        .background(.ypBlue)
                        .cornerRadius(16)
                }
                
            } // VStack
        }
}

#Preview {
    ScheduleView(path: .constant([""]))
        .environmentObject(ScheduleViewModel())
}
