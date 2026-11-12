//
//  DeckCarouselView.swift
//  Wordsy
//
//  Created by aex on 07.08.2026.
//

import SwiftUI

struct DeckCarouselView: View {
    @EnvironmentObject private var container: DIContainer
    let title: String
    let decks: [Deck]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.callout)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(decks) { deck in
                        NavigationLink {
                            DeckView(viewModel: container.makeDeckViewModel(deck: deck))
                        } label: {
                            DeckCarouselCardView(
                                title: deck.title,
                                new: deck.newCount,
                                learning: deck.learningCount,
                                learned: deck.learnedCount
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .fixedSize(horizontal: false, vertical: true)
        }
    }
}

