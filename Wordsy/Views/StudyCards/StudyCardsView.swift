//
//  StudyCardsView.swift
//  Wordsy
//
//  Created by aex on 16.09.2026.
//

import SwiftUI

struct StudyCardsView: View {
    @State private var viewModel: StudyCardsViewModel
    @Environment(\.dismiss) private var dismiss

    init(viewModel: StudyCardsViewModel) {
        self._viewModel = State(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            if viewModel.isFinished {
                StudySummaryView(
                    knownCount: viewModel.knownCount,
                    unknownCount: viewModel.unknownCount,
                    onRestart: { viewModel.restart() },
                    onFinish: { dismiss() }
                )
            } else {
                sessionContent
            }
        }
    }

    // MARK: - Сессия
    private var sessionContent: some View {
        VStack(spacing: 16) {
            topBar

            StudyStageBarView(
                totalCards: viewModel.cards.count,
                currentIndex: viewModel.currentIndex,
                stageSize: viewModel.stageSize
            )

            if let card = viewModel.currentCard {
                StudyCardView(
                    card: card,
                    onKnown: { viewModel.markKnown() },
                    onUnknown: { viewModel.markUnknown() }
                )
                .id(card.id)
            }

            footer
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 12)
    }

    // MARK: - Верхняя панель
    private var topBar: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.body.weight(.medium))
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Text("\(viewModel.currentIndex + 1) / \(viewModel.cards.count)")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .monospacedDigit()
        }
        .frame(height: 44)
    }

    // MARK: - Нижняя панель
    private var footer: some View {
        HStack {
            Label("Ещё учу", systemImage: "arrow.left")
                .font(.caption)
                .foregroundStyle(.secondary)

            Spacer()

            if viewModel.canGoBack {
                Button {
                    withAnimation { viewModel.goBack() }
                } label: {
                    Image(systemName: "arrow.uturn.backward")
                        .font(.body)
                        .foregroundStyle(.secondary)
                }
            }

            Spacer()

            Label("Знаю", systemImage: "arrow.right")
                .font(.caption)
                .foregroundStyle(.secondary)
                .labelStyle(.titleAndIcon)
                .environment(\.layoutDirection, .rightToLeft)
        }
        .frame(height: 32)
    }
}

#Preview {
    NavigationStack {
        StudyCardsView(
            viewModel: StudyCardsViewModel(
                deck: Deck(
                    title: "Английский: слова о характере",
                    cards: [
                        Card(term: "ambitious", definition: "целеустремлённый"),
                        Card(term: "resilient", definition: "стойкий"),
                        Card(term: "humble", definition: "скромный"),
                        Card(term: "stubborn", definition: "упрямый")
                    ],
                    lastOpenedAt: .now,
                    isPublic: false
                ),
                repository: HardCodeDeckRepository()
            )
        )
    }
}
