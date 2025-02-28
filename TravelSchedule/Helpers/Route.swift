//
//  Route.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 23.02.2025.
//

import Foundation

enum Route: Hashable {
    case userAgreementView
    case selectFromCityView
    case selectFromStationView
    case selectToCityView
    case selectToStationView
    case selectCarrierInfoView
    case carriersView
    case noInternetView
    case serverErrorView
}
