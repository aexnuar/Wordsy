//
//  HomeViewModel.swift
//  Wordsy
//
//  Created by aex on 04.08.2026.
//

import Foundation
import Combine

@MainActor
final class HomeViewModel: ObservableObject {
    @Published private(set) var inProgressDecks: [Deck] = []  
    @Published private(set) var mixedCount: Int = 0
    @Published private(set) var dueDecks: [Deck] = []
    @Published private(set) var recentDecks: [Deck] = []
    @Published private(set) var myDecks: [Deck] = []
    @Published var errorMessage: String?
    
    private let repository: DeckRepositoryProtocol
    
    init(repository: DeckRepositoryProtocol) {
        self.repository = repository
        loadHome()
    }
    
    func loadHome() {
        do {
            let ownDecks = try repository.fetchDecks().filter { !$0.isPublic}
            inProgressDecks = getInProgressDecks(ownDecks)
            dueDecks = getDueDecks(ownDecks)
            mixedCount = getMasteringCardCount(ownDecks)
            recentDecks = try repository.fetchRecentlyOpened(limit: 5).filter { !$0.isPublic }
            myDecks = ownDecks
        } catch {
            errorMessage = "Не удалось загрузить данные: \(error.localizedDescription)"
        }
    }
}

// MARK: - loadHome methods
extension HomeViewModel {
    private func getInProgressDecks(_ decks: [Deck]) -> [Deck] { // TODO: методы пока не используются на главном экране, подумать как применить, либо удалить в будущем
        decks.filter { deck in deck.cards.contains { $0.isLearning }
        }
    }
    
    private func getMasteringCardCount(_ decks: [Deck]) -> Int {
        decks.flatMap(\.cards).filter { $0.isLearning }.count
    }
    
    private func getDueDecks(_ decks: [Deck]) -> [Deck] {
        decks.filter { deck in deck.cards.contains { !$0.isLearning && $0.isDue }
        }
    }
}
