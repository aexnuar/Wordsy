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
    
    private let repository: DeckRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(repository: DeckRepositoryProtocol) {
        self.repository = repository
        
        repository.decksPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] decks in
                guard let self else { return }
                
                let ownDecks = decks.filter { !$0.isPublic }
                self.inProgressDecks = getInProgressDecks(ownDecks)
                self.dueDecks = getDueDecks(ownDecks)
                self.mixedCount = getMasteringCardCount(ownDecks)
                self.recentDecks = Array(ownDecks.sorted { $0.lastOpenedAt > $1.lastOpenedAt}.prefix(5))
                self.myDecks = ownDecks
            }
            .store(in: &cancellables)
    }
    
    private func getInProgressDecks(_ decks: [Deck]) -> [Deck] { // TODO: методы пока не используются на главном экране, подумать как применить, либо удалить в будущем
        decks.filter { deck in
            deck.cards.contains { $0.status == .learning }
        }
    }
    
    private func getMasteringCardCount(_ decks: [Deck]) -> Int {
        decks.flatMap(\.cards).filter { $0.status == .learning }.count
    }
    
    private func getDueDecks(_ decks: [Deck]) -> [Deck] {
        decks.filter { deck in
            deck.cards.contains { $0.status != .new && $0.isDue }
        }
    }
}
