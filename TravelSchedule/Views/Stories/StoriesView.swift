//
//  StoriesView.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 22.02.2025.
//

import SwiftUI

struct StoriesView: View {
    
    private let images = ["storiesImage1", "storiesImage2", "storiesImage3"]
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea(.all)
            VStack {
                ScrollView([.horizontal]) {
                    HStack {
                        ForEach(images, id: \.self) { index in
                            Image(index)
                                .resizable()
                                .aspectRatio(2/3, contentMode: .fit)
                                .frame(width: 92, height: 140)
                                .border(Color.blue, width: 4)
                                .cornerRadius(8)
                        }
                    }
                }
            }
        }
    }
}
    
    #Preview {
        StoriesView()
    }
