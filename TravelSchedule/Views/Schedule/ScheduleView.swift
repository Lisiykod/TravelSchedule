//
//  ScheduleView.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 18.02.2025.
//

import SwiftUI

struct ScheduleView: View {
    
    var body: some View {
            VStack(spacing: 16) {
                ZStack {
                    Color.ypBlue
                    HStack(spacing: 16) {
                        VStack(alignment: .leading) {
                            SelectDestinationView(text: nil, placeholder: "Откуда")
                            SelectDestinationView(text: nil, placeholder: "Куда")
                        }
                        .frame(height: 96)
                        .font(.system(size: 17, weight: .regular))
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(.white)
                        )
                        
                        Button {
                            
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
        //        ZStack {
        //            NavigationLink {
        //                SelectCityView()
        //            } label: {
        //                Text("Выбор города")
        //            }
        //            .navigationDestination(for: String.self) { destinationIdentifier in
        //                  if destinationIdentifier == "DetailView" {
        //                      Text("Это детальное представление")
        //                  }
        //              }
        //            Text("")
        //
        //        }
        //        .cornerRadius(20)
        //        .background()
}

#Preview {
    ScheduleView()
}
