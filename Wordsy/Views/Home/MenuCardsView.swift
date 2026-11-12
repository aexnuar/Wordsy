//
//  MenuCardsView.swift
//  Wordsy
//
//  Created by aex on 07.08.2026.
//

import SwiftUI

struct MenuCardsView: View {
    private let spacing: CGFloat = 10

    var body: some View {
        VStack(spacing: spacing) {
            NavigationLink(destination: Text("Экран изучения")) {
                MenuCardView(
                    card: MenuCard(
                        systemImage: "brain",
                        title: "Изучить",
                        subtitle: "Новые слова",
                        iconColor: .purple
                    ),
                    isWide: true
                )
            }

            HStack(spacing: spacing) {
                NavigationLink(destination: Text("Экран вперемешку")) {
                    MenuCardView(card: MenuCard(
                        systemImage: "shuffle",
                        title: "Вперемешку",
                        subtitle: "Все подборки",
                        iconColor: .pink
                    ))
                }

                NavigationLink(destination: Text("Экран повторения")) {
                    MenuCardView(card: MenuCard(
                        systemImage: "arrow.clockwise",
                        title: "Повторить",
                        subtitle: "Пора вспомнить",
                        iconColor: .orange
                    ))
                }
            }
        }
        .buttonStyle(ScaleButtonStyle())
        .hapticTap()
    }
}

#Preview {
    NavigationStack {
        MenuCardsView()
            .padding()
            .background(Color(.systemGray6))
    }
}
