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
                            Text(deck.title)
                                .font(.caption2)
                                .multilineTextAlignment(.leading)
                                .minimumScaleFactor(0.8)
                                .frame(width: 140, height: 60)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .overlay(RoundedRectangle(cornerRadius: 20).stroke())
                        }
                        .buttonStyle(.plain)
                    }
                }
                .frame(height: 60)
            }
        }
    }
}

