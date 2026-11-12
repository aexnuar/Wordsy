//
//  AddView.swift
//  Wordsy
//
//  Created by aex on 06.08.2026.
//

import SwiftUI

//правило простое — "кто показывает следующий экран, тот и достаёт для него ViewModel из контейнера", независимо от того, есть ли у самого показывающего своя ViewModel или нет.

struct AddView: View {
    @EnvironmentObject private var container: DIContainer
    @State private var showCreateDeck = false
    @State private var showCreateFolder = false
    @Binding var isPresented: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Button {
                showCreateDeck = true
            } label: {
                AddCardView(title: "Создать подборку", image: "menucard")
            }
            
            Button {
                showCreateFolder = true
            } label: {
                AddCardView(title: "Создать папку", image: "folder")
            }
        }
        .buttonStyle(ScaleButtonStyle())
        .fullScreenCover(isPresented: $showCreateDeck) {
            CreateDeckView(viewModel: container.makeCreateDeckViewModel(), isPresented: $isPresented)
        }
        .fullScreenCover(isPresented: $showCreateFolder) {
            CreateFolderView(viewModel: container.makeCreateFolderViewModel(), isPresented: $isPresented)
        }
    }
}

#Preview {
    AddView(isPresented: .constant(true))
}

struct AddCardView: View {
    let title: String
    let image: String
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: image)
            Text(title)
        }
    }
}
