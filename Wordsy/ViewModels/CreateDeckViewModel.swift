//
//  CreateDeckViewModel.swift
//  Wordsy
//
//  Created by aex on 14.08.2026.
//

import Foundation
import Combine

@MainActor
final class CreateDeckViewModel: ObservableObject {
    @Published var title: String = ""
    @Published private(set) var cards: [Card] = []
    
    private let repository: DeckRepositoryProtocol
    
    init(repository: DeckRepositoryProtocol) {
        self.repository = repository
        addCard()
        addCard()
    }
    
    func addCard() {
        let newCard = Card(
            term: "",
            definition: ""
        )
        
        cards.append(newCard)
    }
    
    func removeCard(at index: Int) {
        cards.remove(at: index)
    }
    
    func save() {

        //repository.addDeck(//)
    }
}
