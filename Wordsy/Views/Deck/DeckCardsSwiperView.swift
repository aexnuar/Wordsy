//
//  DeckCardsSwiperView.swift
//  Wordsy
//
//  Created by aex on 25.08.2026.
//

import SwiftUI

struct DeckCardsSwiperView: View {
    let cards: [Card]
    @State private var currentIndex = 0
    
    var body: some View {
        VStack {
            TabView(selection: $currentIndex) {
                ForEach(Array(cards.enumerated()), id:\.element.id) { index, card in
                    FlipCardView(card: card)
                        .padding(6)
                        .padding(.bottom, 10)
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 280)
            .padding(-6)
            
            HStack(spacing: 6) {
                ForEach(cards.indices, id: \.self) { index in
                    Circle()
                        .fill(index == currentIndex ? Color.primary : Color.secondary.opacity(0.3))
                        .frame(width: 6, height: 6)
                }
            }
        }
    }
}

struct FlipCardView: View {
    let card: Card
    private let flipDuration = 0.4
    @State private var isFlipped = false
    
    var body: some View {
        Button {
            isFlipped.toggle()
        } label: {
            ZStack {
                cardFace(text: card.term)
                    .opacity(isFlipped ? 0 : 1)
                
                cardFace(text: card.definition)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                    .opacity(isFlipped ? 1 : 0)
            }
            .animation(.linear(duration: 0.01).delay(flipDuration / 2), value: isFlipped) // управляет скоростью смены прозрачности
            .rotation3DEffect(.degrees(isFlipped ? 180 : 0), axis: (x: 0, y: 1, z: 0), perspective: 0.3) // поворот
            .animation(.easeInOut(duration: flipDuration), value: isFlipped) // скоростью поворота
            /*
             Крутиться она должна медленно — это красиво. А текст должен подмениться мгновенно и посередине, пока карточка стоит ребром и её не видно. Иначе заметишь подмену.
             
             Значит нужны две разные скорости. Одной настройкой две скорости не задашь — поэтому строчек .animation две.
             
             Первая говорит: «прозрачность — подожди чуть-чуть и переключи мгновенно».
             Вторая говорит: «поворот — крути плавно».
             */
            
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

/*
 Почему это работает: два .animation(_:value:) на разных уровнях вложенности. Внутренний ловит изменение прозрачности и делает его почти мгновенным, но с задержкой половину поворота — то есть ровно в момент, когда карточка стоит ребром и подмену не видно. Внешний отвечает за сам поворот и остаётся плавным.
 */
