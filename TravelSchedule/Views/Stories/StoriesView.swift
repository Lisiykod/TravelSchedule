//
//  StoriesView.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 22.02.2025.
//

import SwiftUI
import Combine

struct StoriesView: View {
    
    @StateObject private var storiesVM = StoriesViewModel()
    @State private var currentStoryIndex = 0
    @State private var timer: Timer.TimerPublisher = Timer.publish(every: 5, on: .main, in: .common)
    @State private var cancellable: Cancellable?
    private var currentStory: Story { storiesVM.stories[currentStoryIndex] }
    private var progress: CGFloat { CGFloat(currentStoryIndex)/CGFloat(storiesVM.stories.count)}
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoryView(story: currentStory)
            ProgressBar(numberOfSections: storiesVM.stories.count, progress: progress)
                .padding(.init(top: 28, leading: 12, bottom: 12, trailing: 12))
            CloseButton(action: {print("close")})
                .padding(.trailing, 12)
                .padding(.top, 50)
        }
        .onAppear {
            timer = Timer.publish(every: 5, on: .main, in: .common)
            cancellable = timer.connect()
        }
        .onDisappear {
            cancellable?.cancel()
        }
        .onReceive(timer) {_ in
            nextStory()
        }
        .onTapGesture {
            nextStory()
            resetTimer()
        }
    }
    
    private func nextStory() {
        let nextStoryIndex = currentStoryIndex + 1
        if nextStoryIndex < storiesVM.stories.count {
            currentStoryIndex = nextStoryIndex
        } else {
            currentStoryIndex = 0
        }
    }
    
    private func resetTimer() {
        cancellable?.cancel()
        timer = Timer.publish(every: 5, on: .main, in: .common)
        cancellable = timer.connect()
    }
}

#Preview {
    StoriesView()
}
