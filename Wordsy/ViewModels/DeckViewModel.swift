//
//  DeckViewModel.swift
//  Wordsy
//
//  Created by aex on 24.08.2026.
//

import Foundation
import Combine
import Observation

extension Deck {
    var newCount: Int { cards.filter { $0.status == .new }.count }
    var learningCount: Int { cards.filter { $0.status == .learning }.count }
    var learnedCount: Int { cards.filter { $0.status == .learned }.count }
}

@Observable
@MainActor
final class DeckViewModel {
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
    
    var newCount: Int { deck.newCount }
    
    var learningCount: Int { deck.learningCount }
    
    var learnedCount: Int { deck.learnedCount }
    
    func makeStudyCardsViewModel() -> StudyCardsViewModel {
        StudyCardsViewModel(deck: deck, repository: repository)
    }
}
