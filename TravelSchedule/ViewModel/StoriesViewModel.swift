//
//  StoriesViewModel.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 12.03.2025.
//

import Foundation

class StoriesViewModel: ObservableObject {
    @Published var stories = Story.storiesData
    @Published var selectStoryIndex: Int = 0
    
    func showStory(at id: UUID) {
        if let index = stories.firstIndex(where: { $0.id == id }) {
            selectStoryIndex = index
        }
    }
    
    func setStoryAsViewed(at index: Int) {
        stories[index].isViewed = true
    }
    
    func orderedStories()  {
        let viewedStories = stories.filter{$0.isViewed == true}.sorted(by: {$0.imageName < $1.imageName})
        let notViewedStories = stories.filter{$0.isViewed == false}.sorted(by: {$0.imageName < $1.imageName})
        stories = notViewedStories + viewedStories
    }
}
