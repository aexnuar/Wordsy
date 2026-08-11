//
//  DeckRepositoryProtocol.swift
//  Wordsy
//
//  Created by aex on 31.07.2026.
//

import Foundation

protocol DeckRepositoryProtocol {
    func fetchFolders() throws -> [Folder]
    func fetchDecks() throws -> [Deck]
    func fetchRecentlyOpened(limit: Int) throws -> [Deck]
    func addDeck(_ deck: Deck)
    func deleteDeck(_ deck: Deck)
    func addCard(_ card: Card, to deck: Deck)
    func deleteCard(_ card: Card)
    func save() throws
}
