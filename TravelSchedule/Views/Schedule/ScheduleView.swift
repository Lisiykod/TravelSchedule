//
//  ScheduleView.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 18.02.2025.
//

import SwiftUI

struct ScheduleView: View {
    
    @EnvironmentObject private var viewModel: ScheduleViewModel
    @EnvironmentObject private var navigationService: Router
    @StateObject private var storiesVM = StoriesViewModel()
    @State private var isShowingStories: Bool = false
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            VStack(spacing: 16) {
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 12) {
                        ForEach(storiesVM.stories) { story in
                            StoryPreview(story: story)
                                .onTapGesture {
                                    storiesVM.showStory(at: story.id)
                                    isShowingStories = true
                                }
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .frame(height: 188)
                
                ZStack {
                    Color.ypBlue
                    HStack(spacing: 16) {
                        VStack(alignment: .leading) {
                            SelectDestinationView(
                                settlement: viewModel.fromSettlement?.title ?? "",
                                station: viewModel.fromStation?.title ?? "",
                                placeholder: "Откуда"
                            )
                            .onTapGesture {
                                navigationService.push(route: Route.selectFromCityView)
                            }
                            SelectDestinationView(
                                settlement: viewModel.toSettlement?.title ?? "",
                                station: viewModel.toStation?.title ?? "",
                                placeholder: "Куда"
                            )
                            .onTapGesture {
                                navigationService.push(route: Route.selectToCityView)
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
                        
                    }
                    .padding(16)
                }
                .cornerRadius(20)
                .frame(height: 128)
                
                Button {
                    viewModel.isLoading = true
                    Task {
                        await viewModel.search()
                    }
                    navigationService.push(route: Route.carriersView)
                } label: {
                    Text("Найти")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(width: 150, height: 60)
                        .background(.ypBlue)
                        .cornerRadius(16)
                }
                .opacity(viewModel.setSearchButtonEnable() ? 1 : 0 )
                
                Spacer()
            }
            .padding(.horizontal, 16)
        }
        .fullScreenCover(isPresented: $isShowingStories) {
            StoriesView(storiesViewModel: storiesVM)
        }
    }
}

#Preview {
    ScheduleView()
        .environmentObject(ScheduleViewModel())
}
