//
//  Pluralization.swift
//  Wordsy
//
//  Created by aex on 27.08.2026.
//

import Foundation

func cardsCountText(_ count: Int) -> String {
    let rem100 = count % 100
    let rem10 = count % 10
    
    if rem100 >= 11 && rem100 <= 14 { return "\(count) карточек" }
    
    switch rem10 {
    case 1:      return "\(count) карточка"
    case 2...4:  return "\(count) карточки"
    default:     return "\(count) карточек"
    }
}
