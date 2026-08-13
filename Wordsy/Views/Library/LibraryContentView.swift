//
//  LibraryContentView.swift
//  Wordsy
//
//  Created by aex on 13.08.2026.
//

import SwiftUI

struct LibraryContentView: View {
    @ObservedObject var viewModel: LibraryViewModel
    var selectedType: LibraryType
    
    var body: some View {
        ScrollView {
            if selectedType == .mine {
                if !viewModel.myFolders.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(viewModel.myFolders) { folder in
                            LibraryFolderView(folder: folder)
                                .padding(.horizontal, 20)
                        }
                    }
                }
                
                if !viewModel.myDecks.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(viewModel.myDecks) { deck in
                            LibraryDeckView(deck: deck)
                                .padding(.horizontal, 20)
                        }
                    }
                }
                
                // Placeholder для пустого
                if viewModel.myFolders.isEmpty && viewModel.myDecks.isEmpty {
                    EmptyStateView(
                        icon: "tray",
                        title: "Нет материалов",
                        subtitle: "Создайте первую колоду"
                    )
                }
            } else {
                // Публичные колоды
                if viewModel.communityDecks.isEmpty {
                    EmptyStateView(
                        icon: "network",
                        title: "Нет публичных материалов",
                        subtitle: "Публичные колоды появятся здесь"
                    )
                } else {
                    VStack(spacing: 12) {
                        ForEach(viewModel.communityDecks) { deck in
                            LibraryDeckView(deck: deck)
                                .padding(.horizontal, 20)
                        }
                    }
                }
            }
        }
    }
}
