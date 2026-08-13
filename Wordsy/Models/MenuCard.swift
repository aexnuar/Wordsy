//
//  MenuCard.swift
//  Wordsy
//
//  Created by aex on 13.08.2026.
//

import Foundation

struct MenuCard {
    let id = UUID()
    let emoji: String
    let title: String
    let subtitle: String?
    
    init(emoji: String, title: String, subtitle: String? = nil) {
        self.emoji = emoji
        self.title = title
        self.subtitle = subtitle
    }
}
