//
//  DeckCardsListView.swift
//  Wordsy
//
//  Created by aex on 04.09.2026.
//

import SwiftUI

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

#Preview {
    DeckCardsListView(title: "Title", cards: [Card(term: "Term", definition: "Definition")])
}
