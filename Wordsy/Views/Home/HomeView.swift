//
//  HomeView.swift
//  Wordsy
//
//  Created by aex on 04.08.2026.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
//    @Binding var selectedTab: AppTab
    
    init(viewModel: HomeViewModel/*, selectedTab: Binding<AppTab>*/) {
        _viewModel = StateObject(wrappedValue: viewModel)
//        _selectedTab = selectedTab
    }
    
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                MenuCardsView(viewModel: viewModel/*, selectedTab: $selectedTab*/)
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

#Preview {
    HomeView(viewModel: HomeViewModel(repository: HardCodeDeckRepository())/*, selectedTab: .constant(.home)*/)
}
