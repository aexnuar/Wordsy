//
//  MenuCardView.swift
//  Wordsy
//
//  Created by aex on 07.08.2026.
//

import SwiftUI

struct MenuCardView: View {
    let card: MenuCard
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        VStack(spacing: 6) {
            Text(card.emoji)
                .font(.title2)
            
            VStack(spacing: 2) {
                Text(card.title)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.primary) //?
                
                if let subtitle = card.subtitle {
                    Text(subtitle)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .frame(width: width, height: height)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(.rect(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(LinearGradient(
                    colors: [.blue.opacity(0.3), .purple.opacity(0.3)],
                    startPoint: .top,
                    endPoint: .bottom
                ), lineWidth: 2)
        )
    }
}

#Preview {
    MenuCardView(
        card: MenuCard(emoji: "🧠",title: "Изучить"),
        width: 200,
        height: 100
    )
}
