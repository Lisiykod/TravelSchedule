//
//  Story.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 12.03.2025.
//

import Foundation

struct Story: Identifiable, Hashable{
    let id: UUID
    let title: String
    let description: String
    let imageName: String
    var isViewed: Bool

    static let storiesData: [Story] = [
        Story(image: "storiesImage1"),
        Story(image: "storiesImage2"),
        Story(image: "storiesImage3"),
        Story(image: "storiesImage4"),
        Story(image: "storiesImage5")
    ]
    
    init(image: String,
         title: String = "Text Text Text Text Text Text Text Text Text Text Text Text",
         description: String = "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
         isViewed: Bool = false
    ) {
        self.id = UUID()
        self.title = title
        self.description = description
        self.imageName = image
        self.isViewed = isViewed
    }
    
}
