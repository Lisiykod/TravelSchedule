//
//  StoriesViewModel.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 12.03.2025.
//

import Foundation

@MainActor
final class StoriesViewModel: ObservableObject {
    @Published var stories = Story.storiesData
    @Published var selectStoryIndex: Int = 0
    @Published var timerConfiguration: TimerConfiguration
    
    init() {
        self.timerConfiguration = TimerConfiguration(storiesCount: Story.storiesData.count, secondsPerStory: 10)
    }
    
    func showStory(at id: UUID) {
        if let index = stories.firstIndex(where: { $0.id == id }) {
            selectStoryIndex = index
        }
    }
    
    func setStoryAsViewed(at index: Int) {
        if stories.indices.contains(index) {
            stories[index].isViewed = true
        }
    }
    
    func orderedStories()  {
        let viewedStories = stories.filter{$0.isViewed == true}.sorted(by: {$0.imageName < $1.imageName})
        let notViewedStories = stories.filter{$0.isViewed == false}.sorted(by: {$0.imageName < $1.imageName})
        stories = notViewedStories + viewedStories
    }
    
    func createTimer() -> Timer.TimerPublisher {
        Timer.publish(every: timerConfiguration.timerInterval, on: .main, in: .common)
    }
}
