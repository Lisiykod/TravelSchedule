//
//  StoriesView.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 22.02.2025.
//

import SwiftUI
import Combine

struct StoriesView: View {
    
    @ObservedObject private var storiesVM: StoriesViewModel
    
    @State private var timer: Timer.TimerPublisher
    @State private var cancellable: Cancellable?
    @State private var progress: CGFloat
    @Environment(\.dismiss) var dismiss
    
    private var currentStory: Story { storiesVM.stories[currentStoryIndex] }
    private var currentStoryIndex: Int { Int(progress * CGFloat(storiesVM.stories.count)) }
    private var timerConfiguration: TimerConfiguration
    
    init(storiesViewModel: StoriesViewModel) {
        storiesVM = storiesViewModel
        self.timerConfiguration = TimerConfiguration(storiesCount: storiesViewModel.stories.count, secondsPerStory: 2.5)
        self.timer = Self.createTimer(configuration: timerConfiguration)
        progress = timerConfiguration.progress(for: storiesViewModel.selectStoryIndex)
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoryView(story: currentStory)
            ProgressBar(numberOfSections: storiesVM.stories.count, progress: progress)
                .padding(.init(top: 28, leading: 12, bottom: 12, trailing: 12))
            CloseButton {
                dismiss()
            }
            .padding(.trailing, 12)
            .padding(.top, 50)
        }
        .background()
        .onAppear {
            timer = Self.createTimer(configuration: timerConfiguration)
            cancellable = timer.connect()
        }
        .onDisappear {
            cancellable?.cancel()
        }
        .onReceive(timer) {_ in
            timerTick()
        }
        .onTapGesture {
            nextStory()
            resetTimer()
        }
        .gesture(DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
            .onEnded { value in
                print(value.translation)
                switch(value.translation.width, value.translation.height) {
                    case (...0, -30...30):  print("left swipe")
                    case (0..., -30...30):  print("right swipe")
                    case (-100...100, ...0):  print("up swipe")
                    case (-100...100, 0...):  print("down swipe")
                    default:  print("no clue")
                }
            }
        )
    }
    
    private func nextStory() {
        let nextStoryIndex = currentStoryIndex + 1
        if nextStoryIndex == storiesVM.stories.count {
            dismiss()
        } else {
            withAnimation {
                progress = CGFloat(nextStoryIndex)/CGFloat(storiesVM.stories.count)
            }
        }
    }
    
    private func resetTimer() {
        cancellable?.cancel()
        timer = Self.createTimer(configuration: timerConfiguration)
        cancellable = timer.connect()
    }
    
    private static func createTimer(configuration: TimerConfiguration) -> Timer.TimerPublisher {
        Timer.publish(every: configuration.timerInterval, on: .main, in: .common)
    }
    
    private func timerTick() {
        var nextProgress = progress + timerConfiguration.progressPerTick
        if nextProgress >= 1 {
            nextProgress = 0
        }
        withAnimation {
            progress = nextProgress
        }
    }
}

#Preview {
    StoriesView(storiesViewModel: StoriesViewModel())
}
