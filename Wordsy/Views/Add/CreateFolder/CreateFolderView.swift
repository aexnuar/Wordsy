//
//  CreateFolderView.swift
//  Wordsy
//
//  Created by aex on 13.08.2026.
//

import SwiftUI

struct CreateFolderView: View {
    @StateObject private var viewModel: CreateFolderViewModel
    @Binding var isPresented: Bool
    
    init(viewModel: CreateFolderViewModel, isPresented: Binding<Bool>) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self._isPresented = isPresented
    }
    
    var body: some View {
        VStack {
            CreateScreenHeaderView(isPresented: $isPresented, title: "Новая папка") {
                try? viewModel.save()
            }
            
            Spacer()
            
            VStack(spacing: 28) {
                Image(systemName: "folder.fill")
                    .font(.system(size: 70))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [Color(.systemGray6), .purple.opacity(0.7)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                
                TextField("Название папки", text: $viewModel.title)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal, 32)
            }.padding(.top, 20)
            
            Spacer()
            Spacer()
        }
        .padding()
    }
}

#Preview {
    CreateFolderView(viewModel: CreateFolderViewModel(repository: HardCodeDeckRepository()), isPresented: .constant(true))
}
