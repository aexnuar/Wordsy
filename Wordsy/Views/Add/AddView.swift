//
//  AddView.swift
//  Wordsy
//
//  Created by aex on 06.08.2026.
//

import SwiftUI

struct AddView: View {
    @State private var showCreateDeck = false
    @State private var showCreateFolder = false
    @Binding var isPresented: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
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
            CreateDeckView(isPresented: $isPresented)
        }
        .fullScreenCover(isPresented: $showCreateFolder) {
            CreateFolderView(isPresented: $isPresented)
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
