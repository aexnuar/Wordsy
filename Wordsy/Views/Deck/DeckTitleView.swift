//
//  DeckTitleView.swift
//  Wordsy
//
//  Created by aex on 26.08.2026.
//

import SwiftUI

struct DeckTitleView: View {
    let title: String
    let cardsCount: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.callout)
            Text(cardsCountText(cardsCount))
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    DeckTitleView(title: "Title", cardsCount: 3)
}
