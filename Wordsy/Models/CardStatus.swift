//
//  CardStatus.swift
//  Wordsy
//
//  Created by aex on 01.09.2026.
//

import Foundation

enum CardStatus: String, Codable, CaseIterable {
    case new, learning, learned
    
    var title: String {
        switch self {
        case .new:
            "Новые"
        case .learning:
            "Изучаю"
        case .learned:
            "Выучено"
        }
    }
}
