//
//  DeckView.swift
//  Wordsy
//
//  Created by aex on 24.08.2026.
//

import SwiftUI

/*
 DeckView.swift — главный экран
 DeckCardsSwiperView.swift — карточки с переворотом и свайпом
 DeckStudyModesView.swift — кнопки "Заучивание"/"Карточки"
 DeckProgressView.swift — прогресс изучения
 DeckCardsListView.swift — список карточек для просмотра
 */

struct DeckView: View {
    @StateObject private var viewModel: DeckViewModel
    
    init(viewModel: DeckViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                DeckCardsSwiperView(cards: viewModel.cards)
                DeckTitleView(title: viewModel.title, cardsCount: viewModel.cards.count)
                DeckStudyModesView()
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

struct DeckProgressView: View {
    var body: some View {
        EmptyView()
    }
}

struct DeckCardsListView: View {
    let title: String
    let cards: [Card]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.callout)
            
            LazyVStack {
                ForEach(cards) { card in
                    VStack(alignment: .leading, spacing: 12) {
                        Text(card.term)
                            .font(.callout.weight(.medium))
                        Text(card.definition)
                            .font(.subheadline)
                                    .foregroundStyle(.secondary)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.systemGray6))
                    .clipShape(.rect(cornerRadius: 20))
                }
            }
        }
    }
}







