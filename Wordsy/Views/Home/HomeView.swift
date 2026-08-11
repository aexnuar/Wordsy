//
//  HomeView.swift
//  Wordsy
//
//  Created by aex on 04.08.2026.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGray6)
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    MenuCardsView(viewModel: viewModel)
                    DeckCarouselView(title: "Недавние", decks: viewModel.recentDecks)
                    DeckCarouselView(title: "Мои подборки", decks: viewModel.myDecks)
                    Spacer()
                }
                .padding(.top)
                .padding(.horizontal)
            }
            .navigationTitle("Wordsy")
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(repository: HardCodeDeckRepository()))
}
