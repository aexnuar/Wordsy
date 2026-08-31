//
//  DeckCarouselCardView.swift
//  Wordsy
//
//  Created by aex on 26.08.2026.
//

import SwiftUI

struct DeckCarouselCardView: View {
    let title: String

    @ScaledMetric private var height: CGFloat = 60
    @ScaledMetric private var width: CGFloat = 140

    var body: some View {
        Text(title)
            .font(.caption2)
            .multilineTextAlignment(.leading)
            .minimumScaleFactor(0.8)
            .frame(width: width, height: height)
            .background(Color(.secondarySystemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(Color(.systemGray4), lineWidth: 2)
            }
    }
}

#Preview {
    DeckCarouselCardView(title: "Title")
}
