//
//  Folder.swift
//  Wordsy
//
//  Created by aex on 05.08.2026.
//

import Foundation
import SwiftData

@Model
final class Folder { // test git 3
    var id: UUID
    var title: String
    
    @Relationship(deleteRule: .nullify, inverse: \Deck.folder)
    var decks: [Deck]
    
    init(title: String, decks: [Deck]) {
        self.id = UUID()
        self.title = title
        self.decks = decks
    }
}
