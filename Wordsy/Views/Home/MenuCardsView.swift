//
//  MenuCardsView.swift
//  Wordsy
//
//  Created by aex on 07.08.2026.
//

//import SwiftUI
//
//struct MenuCardsView: View {
//    @ScaledMetric private var cardHeight: CGFloat = 100
//    private let spacing: CGFloat = 10
//    
//    var body: some View {
//        GeometryReader { geometry in
//            let bigWidth = geometry.size.width * 0.62
//            let smallWidth = geometry.size.width * 0.34
//            
//            VStack(spacing: spacing) {
//                HStack(spacing: spacing) {
//                    NavigationLink(destination: Text("Экран изучения")) {
//                        MenuCardView(
//                            card: MenuCard(emoji: "🧠", title: "Изучить"),
//                            width: bigWidth,
//                            height: cardHeight
//                        )
//                    }
//                    
//                    NavigationLink(destination: Text("Экран вперемешку")) {
//                        MenuCardView(
//                            card: MenuCard(emoji: "▶️",title: "Вперемешку"),
//                            width: smallWidth,
//                            height: cardHeight
//                        )
//                    }
//                }
//                
//                NavigationLink(destination: Text("Экран повторения")) {
//                    MenuCardView(
//                        card: MenuCard(emoji: "🔄", title: "Повторить"),
//                        width: bigWidth,
//                        height: cardHeight
//                    )
//                }
//            }
//            .buttonStyle(ScaleButtonStyle())
//            .hapticTap()
//        }
//        .frame(height: cardHeight * 2 + spacing)
//    }
//}
//
//#Preview {
//    NavigationStack {
//        MenuCardsView()
//    }
//}

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
