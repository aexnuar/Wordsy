//
//  MenuCard.swift
//  Wordsy
//
//  Created by aex on 13.08.2026.
//

//import Foundation
//
//struct MenuCard {
//    let id = UUID()
//    let emoji: String
//    let title: String
//    let subtitle: String?
//    
//    init(emoji: String, title: String, subtitle: String? = nil) {
//        self.emoji = emoji
//        self.title = title
//        self.subtitle = subtitle
//    }
//}

import SwiftUI

struct MenuCard: Identifiable {
    let id = UUID()
    let systemImage: String
    let title: String
    let subtitle: String?
    let iconColor: Color

    init(
        systemImage: String,
        title: String,
        subtitle: String? = nil,
        iconColor: Color
    ) {
        self.systemImage = systemImage
        self.title = title
        self.subtitle = subtitle
        self.iconColor = iconColor
    }
}
