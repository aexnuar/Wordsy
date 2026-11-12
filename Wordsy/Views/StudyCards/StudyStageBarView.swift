//
//  StudyStageBarView.swift
//  Wordsy
//
//  Created by aex on 16.09.2026.
//

import SwiftUI

struct StudyStageBarView: View {
    let totalCards: Int
    let currentIndex: Int
    let stageSize: Int

    private var stageCount: Int {
        guard totalCards > 0, stageSize > 0 else { return 0 }
        return (totalCards + stageSize - 1) / stageSize
    }

    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<stageCount, id: \.self) { stage in
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color(.systemGray5))

                        Capsule()
                            .fill(Color.emerald)
                            .frame(width: geo.size.width * fillFraction(for: stage))
                    }
                }
            }
        }
        .frame(height: 4)
        .animation(.easeInOut(duration: 0.25), value: currentIndex)
    }

    private func fillFraction(for stage: Int) -> CGFloat {
        let stageStart = stage * stageSize
        let done = currentIndex - stageStart

        guard done > 0 else { return 0 }

        let cardsInStage = min(stageSize, totalCards - stageStart)
        guard cardsInStage > 0 else { return 0 }

        return min(CGFloat(done) / CGFloat(cardsInStage), 1)
    }
}

#Preview {
    VStack(spacing: 30) {
        StudyStageBarView(totalCards: 25, currentIndex: 0, stageSize: 5)
        StudyStageBarView(totalCards: 25, currentIndex: 7, stageSize: 5)
        StudyStageBarView(totalCards: 25, currentIndex: 25, stageSize: 5)
        StudyStageBarView(totalCards: 3, currentIndex: 1, stageSize: 5)
    }
    .padding()
}
