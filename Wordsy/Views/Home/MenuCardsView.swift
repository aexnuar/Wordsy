//
//  MenuCardsView.swift
//  Wordsy
//
//  Created by aex on 07.08.2026.
//

import SwiftUI

struct MenuCardsView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width * 0.62
            let width2 = geometry.size.width * 0.34
            
            VStack(alignment: .center, spacing: 10) {
                HStack(spacing: 10) {
                    NavigationLink(destination: Text("Экран изучения")) {
                        MenuCardView(
                            card: MenuCard(emoji: "🧠", title: "Изучить"),
                            width: width,
                            height: 100
                        )
                    }
                    
                    NavigationLink(destination: Text("Экран вперемешку")) {
                        MenuCardView(
                            card: MenuCard(
                                emoji: "▶️",
                                title: "Вперемешку"
                                //subtitle: "\(viewModel.mixedCount) карт"
                            ),
                            width: width2,
                            height: 100
                        )
                    }
                }
                
                HStack(spacing: 10) {
                    NavigationLink(destination: Text("Экран повторения")) {
                        MenuCardView(
                            card: MenuCard(emoji: "🔄", title: "Повторить"),
                            width: width,
                            height: 100
                        )
                    }
                    
                    NavigationLink(destination: Text("Экран библиотеки")) {
                        MenuCardView(
                            card: MenuCard(emoji: "📚", title: "Моя библиотека"),
                            width: width2,
                            height: 100
                        )
                    }
                }
            }
            .buttonStyle(ScaleButtonStyle())
            .hapticTap()
        }
        .frame(height: 210)
    }
}

#Preview {
    NavigationStack {
        MenuCardsView(viewModel: HomeViewModel(repository: HardCodeDeckRepository()))
            .padding()
    }
}
