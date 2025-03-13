//
//  StoriesViewModel.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 12.03.2025.
//

import Foundation

class StoriesViewModel: ObservableObject {
    @Published var stories = Story.storiesData
}
