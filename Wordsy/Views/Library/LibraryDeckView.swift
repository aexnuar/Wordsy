//
//  LibraryDeckView.swift
//  Wordsy
//
//  Created by aex on 13.08.2026.
//

import SwiftUI

struct LibraryDeckView: View {
    @EnvironmentObject private var container: DIContainer
    let deck: Deck
    
    var body: some View {
        NavigationLink {
            DeckView(viewModel: container.makeDeckViewModel(deck: deck))
        } label: {
            HStack(spacing: 12) {
                Image(systemName: "menucard")
                    .font(.callout)
                    .foregroundStyle(.white)
                    .frame(width: 40, height: 40)
                    .background(
                        LinearGradient(
                            colors: [.blue, .purple],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 3) {
                    Text(deck.title)
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundStyle(.primary)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    
                    Text("\(deck.cards.count) карточек")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
            }
            .frame(height: 76)
            .padding(.horizontal, 16)
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
        }
        .buttonStyle(ScaleButtonStyle())
        .hapticTap()
        
    }
}
