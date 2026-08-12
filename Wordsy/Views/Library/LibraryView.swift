//
//  LibraryView.swift
//  Wordsy
//
//  Created by aex on 06.08.2026.
//

import SwiftUI

struct LibraryView: View {
    @StateObject private var viewModel: LibraryViewModel
    @State private var selectedType: LibraryType = .mine
    
    init(viewModel: LibraryViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: 10) {
            HeaderView()
                .padding(.horizontal, 20)
            
            HStack(spacing: 40) {
                LibraryTabView(selectedType: $selectedType, title: "Мои материалы", type: .mine)
                LibraryTabView(selectedType: $selectedType, title: "Публичные", type: .community)
                Spacer()
            }
            .padding(.horizontal, 20)
            
            Divider()
            
            LibraryContentView(viewModel: viewModel, selectedType: selectedType)
                .padding(.top, 10)
        }
        .padding(.vertical, 10)
        .background(Color(.systemGray6).ignoresSafeArea())
    }
}

#Preview {
    LibraryView(viewModel: LibraryViewModel(repository: HardCodeDeckRepository()))
}

struct HeaderView: View {
    var body: some View {
        HStack {
            Text("Библиотека")
                .font(.title)
                .bold()
            Spacer()
            Button {
                //
            } label: {
                Image(systemName: "ellipsis.circle")
                    .font(.title3)
                    .foregroundStyle(Color(.darkGray))
            }
        }
    }
}

struct LibraryTabView: View {
    @Binding var selectedType: LibraryType
    let title: String
    let type: LibraryType
    
    var body: some View {
        Button {
            selectedType = type
        } label: {
            Text(title)
                .fixedSize()
                .foregroundStyle(selectedType == type ? .primary : .secondary)
        }
        .buttonStyle(.plain)
    }
}

struct LibraryContentView: View {
    @ObservedObject var viewModel: LibraryViewModel
    var selectedType: LibraryType
    
    var body: some View {
        ScrollView {
            if selectedType == .mine {
                if !viewModel.myFolders.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(viewModel.myFolders) { folder in
                            FolderCardView(folder: folder)
                                .padding(.horizontal, 20)
                        }
                    }
                }
                
                if !viewModel.myDecks.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(viewModel.myDecks) { deck in
                            DeckCardView(deck: deck)
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
                            DeckCardView(deck: deck)
                                .padding(.horizontal, 20)
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Card Views
    struct FolderCardView: View {
        let folder: Folder
        
        var body: some View {
            NavigationLink(destination: Text("Экран папки")) {
                HStack(spacing: 12) {
                    Image(systemName: "folder.fill")
                        .font(.callout)
                        .foregroundStyle(.white)
                        .frame(width: 40, height: 40)
                        .background(
                            LinearGradient(
                                colors: [.orange, .yellow],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 3) {
                        Text(folder.title)
                            .font(.body)
                            .fontWeight(.medium)
                            .foregroundStyle(.primary)
                            .lineLimit(1)
                            .truncationMode(.tail)
                        
                        Text("Папка")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                }
                .frame(height: 76)
                .padding(.horizontal, 16)
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
            }
            .buttonStyle(ScaleButtonStyle())
            .hapticTap()
        }
    }
    
    struct DeckCardView: View {
        let deck: Deck
        
        var body: some View {
            NavigationLink(destination: Text("Экран подборки")) {
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
    
    struct EmptyStateView: View {
        let icon: String
        let title: String
        let subtitle: String
        
        var body: some View {
            VStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 60))
                    .foregroundStyle(.blue.gradient)
                    .symbolEffect(.pulse)
                
                VStack(spacing: 8) {
                    Text(title)
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 100)
        }
    }
}






