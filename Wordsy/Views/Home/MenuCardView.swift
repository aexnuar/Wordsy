//
//  MenuCardView.swift
//  Wordsy
//
//  Created by aex on 07.08.2026.
//

import SwiftUI

struct MenuCard {
    let id = UUID()
    let emoji: String
    let title: String
    let subtitle: String?
    
    init(emoji: String, title: String, subtitle: String? = nil) {
        self.emoji = emoji
        self.title = title
        self.subtitle = subtitle
    }
}

struct MenuCardView: View {
    let card: MenuCard
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        VStack(alignment: .center, spacing: 6) {
            Text(card.emoji)
                .font(.system(size: 24))
            
            VStack(spacing: 2) {
                Text(card.title)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
                
                if let subtitle = card.subtitle {
                    Text(subtitle)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .frame(width: width, height: height)
        .background(.white)
        .clipShape(.rect(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(LinearGradient(
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
