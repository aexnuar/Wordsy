//
//  StudySummaryView.swift
//  Wordsy
//
//  Created by aex on 16.09.2026.
//

import SwiftUI

struct StudySummaryView: View {
    let knownCount: Int
    let unknownCount: Int
    let onRestart: () -> Void
    let onFinish: () -> Void

    private var total: Int { knownCount + unknownCount }

    var body: some View {
        VStack(spacing: 28) {
            Spacer()

            VStack(spacing: 6) {
                Text("Сессия завершена")
                    .font(.title2.weight(.semibold))

                Text(cardsCountText(total))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            HStack(spacing: 10) {
                counter(count: knownCount, title: "Знаю", color: .emerald)
                counter(count: unknownCount, title: "Ещё учу", color: .burgundy)
            }

            Spacer()

            VStack(spacing: 10) {
                Button(action: onRestart) {
                    Text("Пройти ещё раз")
                        .font(.body.weight(.medium))
                        .foregroundStyle(Color(.systemBackground))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color(.label))
                        .clipShape(.rect(cornerRadius: 14))
                }

                Button(action: onFinish) {
                    Text("Готово")
                        .font(.body)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                }
            }
        }
        .padding(20)
    }

    private func counter(count: Int, title: String, color: Color) -> some View {
        VStack(spacing: 4) {
            Text("\(count)")
                .font(.system(size: 34, weight: .semibold))
                .foregroundStyle(color)

            Text(title)
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(color.opacity(0.12))
        .clipShape(.rect(cornerRadius: 16))
    }
}

#Preview {
    StudySummaryView(
        knownCount: 8,
        unknownCount: 4,
        onRestart: {},
        onFinish: {}
    )
}
