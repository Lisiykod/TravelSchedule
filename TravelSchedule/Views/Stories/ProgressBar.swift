//
//  ProgressBar.swift
//  TravelSchedule
//
//  Created by Olga Trofimova on 13.03.2025.
//

import SwiftUI

extension CGFloat {
    static let progressBarCornerRadius: CGFloat = 3
    static let progressBarHeight: CGFloat = 6
}

struct ProgressBar: View {
    
    let numberOfSections: Int
    let progress: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: .progressBarHeight)
                    .foregroundStyle(.ypWhiteUniversal)
                Rectangle()
                    .frame(
                        width: min(
                            progress * geometry.size.width,
                            geometry.size.width
                        ),
                        height: .progressBarHeight
                    )
                    .foregroundStyle(.ypBlueUniversal)
            }
            .mask {
                MaskView(numberOfSections: numberOfSections)
            }
            
        }
    }
}


private struct MaskFragmentView: View {
    var body: some View {
        Rectangle()
            .fixedSize(horizontal: false, vertical: true)
            .frame(height: 6)
            .foregroundStyle(.ypWhiteUniversal)
    }
}

private struct MaskView: View {
    
    let numberOfSections: Int
    
    var body: some View {
        HStack {
            ForEach(0..<numberOfSections, id: \.self) { _ in
                MaskFragmentView()
                    .clipShape(RoundedRectangle(cornerRadius: .progressBarCornerRadius))
            }
        }
    }
}

#Preview {
    Color.gray
         .ignoresSafeArea()
         .overlay(
            ProgressBar(numberOfSections: 5, progress: 0.5)
                .padding()
         )
}
