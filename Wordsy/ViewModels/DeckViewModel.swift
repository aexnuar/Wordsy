//
//  DeckViewModel.swift
//  Wordsy
//
//  Created by aex on 24.08.2026.
//

import Foundation
import Combine

@MainActor
final class DeckViewModel: ObservableObject {
    private let deck: Deck
    private let repository: DeckRepositoryProtocol
    
    init(deck: Deck, repository: DeckRepositoryProtocol) {
        self.deck = deck
        self.repository = repository
    }
    
    var title: String {
        deck.title
    }
    
    var cards: [Card] {
           deck.cards
    }
}
