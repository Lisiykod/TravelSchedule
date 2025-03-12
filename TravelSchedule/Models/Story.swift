//
//  Story.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 12.03.2025.
//

import SwiftUI

struct Story: Identifiable {
    let id: UUID
    let title: String
    let description: String
    let image: Image
    var isViewed: Bool
    
    static let storiesData: [Story] = [
        Story(image: Image("storiesImage1")),
        Story(image: Image("storiesImage2")),
        Story(image: Image("storiesImage3")),
        Story(image: Image("storiesImage4")),
        Story(image: Image("storiesImage5"))
    ]
    
    init(image: Image,
         title: String = "Text Text Text Text Text Text Text Text Text Text Text Text",
         description: String = "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
         isViewed: Bool = false
    ) {
        self.id = UUID()
        self.title = title
        self.description = description
        self.image = image
        self.isViewed = isViewed
    }
    
}
