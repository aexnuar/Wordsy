//
//  MenuCardView.swift
//  Wordsy
//
//  Created by aex on 07.08.2026.
//

//import SwiftUI
//
//struct MenuCardView: View {
//    let card: MenuCard
//    let width: CGFloat
//    let height: CGFloat
//    
//    var body: some View {
//        VStack(spacing: 6) {
//            Text(card.emoji)
//                .font(.title2)
//            
//            VStack(spacing: 2) {
//                Text(card.title)
//                    .font(.caption.weight(.semibold))
//                    .foregroundStyle(.primary) //?
//                
//                if let subtitle = card.subtitle {
//                    Text(subtitle)
//                        .font(.caption2)
//                        .foregroundStyle(.secondary)
//                }
//            }
//        }
//        .frame(width: width, height: height)
//        .background(Color(.secondarySystemGroupedBackground))
//        .clipShape(.rect(cornerRadius: 20))
//        .overlay(
//            RoundedRectangle(cornerRadius: 20)
//                .strokeBorder(LinearGradient(
//                    colors: [.blue.opacity(0.3), .purple.opacity(0.3)],
//                    startPoint: .top,
//                    endPoint: .bottom
//                ), lineWidth: 2)
//        )
//    }
//}
//
//#Preview {
//    MenuCardView(
//        card: MenuCard(emoji: "🧠",title: "Изучить"),
//        width: 200,
//        height: 100
//    )
//}

import SwiftUI

struct MenuCardView: View {
    let card: MenuCard
    var isWide: Bool = false

    var body: some View {
        Group {
            if isWide {
                HStack(spacing: 12) {
                    IconPlaqueView(systemImage: card.systemImage, color: card.iconColor)
                    texts
                    Spacer(minLength: 0)
                }
            } else {
                VStack(alignment: .leading, spacing: 10) {
                    IconPlaqueView(systemImage: card.systemImage, color: card.iconColor)
                    texts
                }
            }
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(.rect(cornerRadius: 16))
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(Color(.systemGray4), lineWidth: 1)
        }
    }

    private var texts: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(card.title)
                .font(.callout)
                .foregroundStyle(.primary)

            if let subtitle = card.subtitle {
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    VStack(spacing: 10) {
        MenuCardView(
            card: MenuCard(
                systemImage: "brain",
                title: "Изучить",
                subtitle: "12 новых слов",
                iconColor: .purple
            ),
            isWide: true
        )

        HStack(spacing: 10) {
            MenuCardView(card: MenuCard(
                systemImage: "shuffle",
                title: "Вперемешку",
                subtitle: "Все подборки",
                iconColor: .pink
            ))

            MenuCardView(card: MenuCard(
                systemImage: "arrow.clockwise",
                title: "Повторить",
                subtitle: "8 карточек",
                iconColor: .orange
            ))
        }
    }
    .padding()
    .background(Color(.systemGray6))
}
