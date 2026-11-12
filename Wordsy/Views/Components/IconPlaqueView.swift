//
//  IconPlaqueView.swift
//  Wordsy
//
//  Created by aex on 12.11.2026.
//

import SwiftUI

struct IconPlaqueView: View {
    let systemImage: String
    let color: Color

    @ScaledMetric private var iconSize: CGFloat = 22
    @ScaledMetric private var padding: CGFloat = 8

    var body: some View {
        Image(systemName: systemImage)
            .frame(width: iconSize, height: iconSize)
            .padding(padding)
            .background(color.opacity(0.7))
            .clipShape(.rect(cornerRadius: 8))
    }
}
