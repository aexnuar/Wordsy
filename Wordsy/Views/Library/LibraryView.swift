//
//  LibraryView.swift
//  Wordsy
//
//  Created by aex on 06.08.2026.
//

import SwiftUI

enum LibraryType {
    case mine, community
}

struct LibraryView: View { //test git 3
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
        if selectedType == .mine {
            List {
                Section {
                    ForEach(viewModel.myFolders) { folder in
                        HStack {
                            Image(systemName: "folder")
                            Text(folder.title)
                        }
                        .listRowSeparator(.hidden)
                    }
                }
                
                Section {
                    ForEach(viewModel.myDecks) { deck in
                        HStack {
                            Image(systemName: "menucard")
                            Text(deck.title)
                        }
                        .listRowSeparator(.hidden)
                    }
                }
            }
        } else {
            if viewModel.communityDecks.isEmpty {
                VStack(spacing: 16) {
                    Image(systemName: "tray")
                        .font(.system(size: 60))
                        .foregroundStyle(.secondary)
                    Text("Нет публичных материалов")
                        .font(.title3)
                        .foregroundStyle(.secondary)
                    Text("Публичные колоды появятся здесь")
                        .font(.subheadline)
                        .foregroundStyle(.tertiary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List {
                    ForEach(viewModel.communityDecks) { deck in
                        HStack {
                            Image(systemName: "menucard")
                            Text(deck.title)
                        }
                        .listRowSeparator(.hidden)
                    }
                }
            }
        }
    }
}






