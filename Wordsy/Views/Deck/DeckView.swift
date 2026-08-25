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
        VStack(alignment: .leading, spacing: 20) {
            Text(viewModel.title)
            DeckCardsSwiperView(cards: viewModel.cards)
            Spacer()
        }
    }
}


#Preview {
    DeckCardsSwiperView(cards: [
        Card(term: "ambitious", definition: "целеустремлённый"),
        Card(term: "resilient", definition: "стойкий")
    ])
}

struct DeckCardsSwiperView: View {
    let cards: [Card]
    
    var body: some View {
        TabView {
            ForEach(cards, id:\.id) { card in
                FlipCardView(card: card)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .frame(height: 320)
    }
}

struct FlipCardView: View {
    let card: Card
    @State private var isFlipped = false
    
    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.4)) {
                isFlipped.toggle()
            }
        } label: {
            ZStack {
                cardFace(text: card.term)
                    .opacity(isFlipped ? 0 : 1)
                
                cardFace(text: card.definition)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                    .opacity(isFlipped ? 1 : 0)
            }
            .rotation3DEffect(.degrees(isFlipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
        }
        .buttonStyle(.plain)
        .hapticTap()
    }
    
    private func cardFace(text: String) -> some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color(.systemGray6))
            .overlay {
                Text(text)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding()
            }
    }
}
