//
//  DeckCarouselCardView.swift
//  Wordsy
//
//  Created by aex on 26.08.2026.
//

import SwiftUI

struct DeckCarouselCardView: View {
    let title: String
    let new: Int
    let learning: Int
    let learned: Int

    @ScaledMetric private var width: CGFloat = 150

    private var total: Int { new + learning + learned }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.caption)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .frame(maxWidth: .infinity, alignment: .leading)

            Spacer(minLength: 0)

            progressBar

            Text(progressText)
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .padding(12)
        .frame(width: width, height: 110, alignment: .topLeading)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(.rect(cornerRadius: 20))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(Color(.systemGray4), lineWidth: 1)
        }
    }

    private var progressBar: some View {
        GeometryReader { geo in
            HStack(spacing: 0) {
                segment(learned, Color(.systemGreen), geo.size.width)
                segment(learning, Color(.systemOrange), geo.size.width)
                segment(new, Color(.systemGray4), geo.size.width)
            }
        }
        .frame(height: 4)
        .clipShape(Capsule())
    }

    @ViewBuilder
    private func segment(_ count: Int, _ color: Color, _ totalWidth: CGFloat) -> some View {
        if count > 0 && total > 0 && totalWidth > 0 {
            color.frame(width: CGFloat(count) / CGFloat(total) * totalWidth)
        }
    }

    private var progressText: String {
        guard total > 0 else { return "Нет карточек" }
        guard learned > 0 || learning > 0 else { return "Не начата" }
        return "\(learned) из \(total)"
    }
}

#Preview {
    HStack(spacing: 10) {
        DeckCarouselCardView(title: "Английский: слова о характере", new: 4, learning: 3, learned: 5)
        DeckCarouselCardView(title: "Немецкий", new: 10, learning: 0, learned: 0)
    }
    .padding()
    .background(Color(.systemGray6))
}
