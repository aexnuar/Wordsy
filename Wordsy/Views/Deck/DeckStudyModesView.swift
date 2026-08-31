//
//  DeckStudyModesView.swift
//  Wordsy
//
//  Created by aex on 26.08.2026.
//

import SwiftUI

struct DeckStudyModesView: View {
//    let onCardsMode: () -> Void
//    let onLearnMode: () -> Void
    
    var body: some View {
        VStack {
            StudyModeCardView(
                image: "rectangle.on.rectangle",
                title: "Карточки",
                description: "Изучай и отмечай выучены или нет",
                iconColor: .pink,
                action: {}
            )
            
            StudyModeCardView(
                image: "brain",
                title: "Заучивание",
                description: "Изучай по алгоритму запоминания",
                iconColor: .purple,
                action: {}
            )
        }
    }
}

#Preview {
    DeckStudyModesView()
}
