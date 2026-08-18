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
            LibraryHeaderView()
                .padding(.horizontal, 20)
            
            HStack(spacing: 40) {
                LibraryTabView(selectedType: $selectedType, title: "Моё", type: .mine)
                LibraryTabView(selectedType: $selectedType, title: "Публичное", type: .community)
                Spacer()
            }
            .padding(.horizontal, 20)
            
            Divider()
            
            LibraryContentView(viewModel: viewModel, selectedType: selectedType)
                .padding(.top, 10)
        }
        .padding(.vertical, 10)
        .background(Color(.systemGray6).ignoresSafeArea())
        .onAppear { viewModel.loadLibrary() }
    }
}

#Preview {
    LibraryView(viewModel: LibraryViewModel(repository: HardCodeDeckRepository()))
}
