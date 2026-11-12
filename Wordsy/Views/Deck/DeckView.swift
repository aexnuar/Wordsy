//
//  DeckView.swift
//  Wordsy
//
//  Created by aex on 24.08.2026.
//

import SwiftUI

struct DeckView: View {
    @State private var viewModel: DeckViewModel
    @State private var isStudyingCards = false
    
    init(viewModel: DeckViewModel) {
        self._viewModel = State(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                DeckCardsSwiperView(cards: viewModel.cards)
                
                DeckTitleView(title: viewModel.title, cardsCount: viewModel.cards.count)
                
                DeckProgressView(
                    new: viewModel.newCount,
                    learning: viewModel.learningCount,
                    learned: viewModel.learnedCount
                )
                
                DeckStudyModesView(
                    onCardsMode: { isStudyingCards = true },
                    onLearnMode: { }
                )
                
                DeckCardsListView(title: "Карточки", cards: viewModel.cards)
            }
            .padding()
        }
        .scrollIndicators(.hidden)
        .fullScreenCover(isPresented: $isStudyingCards) {
            StudyCardsView(viewModel: viewModel.makeStudyCardsViewModel())
        }
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







