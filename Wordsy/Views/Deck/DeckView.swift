//
//  DeckView.swift
//  Wordsy
//
//  Created by aex on 24.08.2026.
//

import SwiftUI

struct DeckView: View {
    @State private var viewModel: DeckViewModel
    
    init(viewModel: DeckViewModel) {
        self._viewModel = State(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                DeckCardsSwiperView(cards: viewModel.cards)
                DeckTitleView(title: viewModel.title, cardsCount: viewModel.cards.count)
                DeckStudyModesView()
                DeckProgressView(new: viewModel.newCount, learning: viewModel.learningCount, learned: viewModel.learnedCount)
                DeckCardsListView(title: "Карточки", cards: viewModel.cards)
            }
            .padding()
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    DeckView(viewModel: DeckViewModel(
        deck: Deck(
            title: "Английский: слова о характере",
            cards: [
                Card(term: "ambitious", definition: "целеустремлённыйцелеустремлённыйцелеустремлённыйцелеустремлённыйцелеустремлённый"),
                Card(term: "resilient", definition: "стойкий"),
                Card(term: "ambitious", definition: "целеустремлённый"),
                Card(term: "resilient", definition: "стойкий"),
                Card(term: "ambitious", definition: "целеустремлённый"),
                Card(term: "resilient", definition: "стойкий"),
                Card(term: "ambitious", definition: "целеустремлённый"),
                Card(term: "resilient", definition: "стойкий"),
                Card(term: "ambitious", definition: "целеустремлённый"),
                Card(term: "resilient", definition: "стойкий"),
                Card(term: "ambitious", definition: "целеустремлённый"),
                Card(term: "resilient", definition: "стойкий"),
                Card(term: "ambitious", definition: "целеустремлённый"),
                Card(term: "resilient", definition: "стойкий"),
                Card(term: "ambitious", definition: "целеустремлённый"),
                Card(term: "resilient", definition: "стойкий")
            ],
            lastOpenedAt: .now,
            isPublic: false
        ),
        repository: HardCodeDeckRepository()
    ))
}







