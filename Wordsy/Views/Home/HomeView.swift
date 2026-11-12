//
//  HomeView.swift
//  Wordsy
//
//  Created by aex on 04.08.2026.
//

import SwiftUI

//struct HomeView: View {
//    @StateObject private var viewModel: HomeViewModel
//    
//    init(viewModel: HomeViewModel) {
//        _viewModel = StateObject(wrappedValue: viewModel)
//    }
//    
//    var body: some View {
//        ZStack {
//            Color(.systemGray6)
//                .ignoresSafeArea()
//            
//            VStack(spacing: 30) {
//                MenuCardsView()
//                DeckCarouselView(title: "Недавние", decks: viewModel.recentDecks)
//                DeckCarouselView(title: "Мои подборки", decks: viewModel.myDecks)
//                Spacer()
//            }
//            .padding()
//        }
//        .navigationTitle("Wordsy")
//    }
//}
//
//#Preview {
//    NavigationStack {
//        HomeView(viewModel: HomeViewModel(repository: HardCodeDeckRepository()))
//    }
//    .environmentObject(DIContainer())
//}

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 26) {
                    MenuCardsView()
                    DeckCarouselView(title: "Недавние", decks: viewModel.recentDecks)
                    DeckCarouselView(title: "Мои подборки", decks: viewModel.myDecks)
                }
                .padding()
            }
            .scrollIndicators(.hidden)
        }
        .navigationTitle("Wordsy")
    }
}

#Preview {
    NavigationStack {
        HomeView(viewModel: HomeViewModel(repository: HardCodeDeckRepository()))
    }
    .environmentObject(DIContainer())
}
