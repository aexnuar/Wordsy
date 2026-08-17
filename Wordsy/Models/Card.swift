//
//  Card.swift
//  Wordsy
//
//  Created by aex on 31.07.2026.
//

import Foundation
import SwiftData

@Model
final class Card {
    var id: UUID
    var term: String
    var definition: String
    var example: String = ""
    var image: Data?
    var repetitions: Int
    var dueDate: Date
    
    var deck: Deck?
    
    var isLearning: Bool {
        repetitions == 0
    }
    
    var isDue: Bool {
        dueDate <= .now
    }
    
    init(term: String, definition: String, example: String = "", image: Data? = nil) {
        self.id = UUID()
        self.term = term
        self.definition = definition
        self.example = example
        self.image = image
        self.repetitions = 0
        self.dueDate = .now
    }
}
