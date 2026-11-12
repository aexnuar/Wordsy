//
//  StudyCardView.swift
//  Wordsy
//
//  Created by aex on 16.09.2026.
//

import SwiftUI

struct StudyCardView: View {
    let card: Card
    let onKnown: () -> Void
    let onUnknown: () -> Void
    
    @State private var isFlipped = false
    @State private var offset: CGSize = .zero
    
    private let swipeThreshold: CGFloat = 120
    
    var body: some View {
        content
            .overlay { verdictOverlay }
            .rotationEffect(.degrees(dragProgress * 12))
            .offset(offset)
            .gesture(dragGesture)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.35)) {
                    isFlipped.toggle()
                }
            }
    }
    
    // MARK: - Содержимое карточки
    private var content: some View {
        Text(isFlipped ? card.term : card.definition)
            .font(.system(size: 26, design: .serif))
            .frame(maxWidth: .infinity, minHeight: 560)
//            .padding(28)
//            .multilineTextAlignment(.center)
            .background(Color(.systemGray6))
            .clipShape(.rect(cornerRadius: 24))
            .overlay {
                RoundedRectangle(cornerRadius: 24)
                    .strokeBorder(Color(.label), lineWidth: 1)
            }
    }
    
    // MARK: - Обратная связь при свайпе
    private var verdictOverlay: some View {
        ZStack {
            Color.emerald.opacity(dragProgress > 0 ? dragProgress : 0)
            Color.burgundy.opacity(dragProgress < 0 ? -dragProgress : 0)
            
            Text(dragProgress > 0 ? "Знаю" : "Ещё учу")
                .font(.title2.weight(.semibold))
                .foregroundStyle(dragProgress > 0 ? .white : .red)
                .opacity(abs(dragProgress))
        }
        .clipShape(.rect(cornerRadius: 24))
        .allowsHitTesting(false)
    }
    
    // MARK: - Жест перетаскивания
    private var dragGesture: some Gesture {
        DragGesture(minimumDistance: 10)
            .onChanged { value in
                offset = value.translation
            }
            .onEnded { value in
                if value.translation.width > swipeThreshold {
                    flyAway(to: 600, then: onKnown)
                } else if value.translation.width < -swipeThreshold {
                    flyAway(to: -600, then: onUnknown)
                } else {
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
                        offset = .zero
                    }
                }
            }
    }
    
    // MARK: - Вспомогательное
    private var dragProgress: CGFloat {
        max(min(offset.width / swipeThreshold, 1), -1)
    }
    
    private func flyAway(to x: CGFloat, then action: @escaping () -> Void) {
        withAnimation(.easeOut(duration: 0.25)) {
            offset = CGSize(width: x, height: offset.height)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            action()
        }
    }
}

#Preview {
    StudyCardView(
        card: Card(term: "ambitious", definition: "целеустремлённый"),
        onKnown: {},
        onUnknown: {}
    )
    .padding()
}
