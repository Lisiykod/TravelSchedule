//
//  MainView.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 07.02.2025.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var navigationService = Router.shared
    
    var body: some View {
        
        NavigationStack(path: $navigationService.path) {
            ZStack {
                Color.ypWhite.ignoresSafeArea()
                TabView {
                    ScheduleView()
                        .tabItem {
                            Image("arrowUpIcon")
                                .renderingMode(.template)
                        }
                    
                    SettingsView()
                        .tabItem {
                            Image("SettingsIcon")
                                .renderingMode(.template)
                        }
                }
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case Route.userAgreementView:
                        UserAgreementView()
                    case Route.selectFromCityView:
                        SelectCityView(direction: .from)
                    case Route.selectFromStationView:
                        SelectStationView(direction: .from)
                    case Route.selectToCityView:
                        SelectCityView(direction: .to)
                    case Route.selectToStationView:
                        SelectStationView(direction: .to)
                    case Route.carriersView:
                        CarriersView()
                    case Route.noInternetView:
                        ErrorsView(error: .internetConnectError)
                    case Route.serverErrorView:
                        ErrorsView(error: .serverError)
                    case .selectCarrierInfoView:
                        CarrierInfoView()
                    case .filtersView:
                        FiltersView()
                    }
                }
            }
        }
        .tint(.ypBlack)
    
    }
    
}

#Preview {
    MainView()
        .environmentObject(ScheduleViewModel())
}
