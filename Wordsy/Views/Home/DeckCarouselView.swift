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
        VStack(alignment: .leading) {
            Text(title)
                .font(.subheadline)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(decks) { deck in
                        NavigationLink {
                            DeckView(viewModel: container.makeDeckViewModel(deck: deck))
                        } label: {
                            DeckCarouselCardView(title: deck.title)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            //.frame(height: 60)
            .fixedSize(horizontal: false, vertical: true)
            //.contentMargins(.horizontal, 16)
        }
    }
}

