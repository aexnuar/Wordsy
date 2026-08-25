//
//  CreateDeckView.swift
//  Wordsy
//
//  Created by aex on 13.08.2026.
//

import SwiftUI
import PhotosUI

struct CreateDeckView: View {
    @StateObject private var viewModel: CreateDeckViewModel
    @Binding var isPresented: Bool
    
    init(viewModel: CreateDeckViewModel, isPresented: Binding<Bool>) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self._isPresented = isPresented
    }
    
    var body: some View {
        VStack {
            CreateScreenHeaderView(isPresented: $isPresented, title: "Новая подборка") {
                try? viewModel.save()
            }
            
            TextField("Введите название", text: $viewModel.title)
                .font(.headline)
                .padding(.top, 20)
            
            CreateRowsDeckView(viewModel: viewModel)
        }
        .padding()
    }
}

#Preview {
    CreateDeckView(viewModel: CreateDeckViewModel(repository: HardCodeDeckRepository()), isPresented: .constant(true))
}

//struct CreateHeaderDeckView: View {
//    @ObservedObject var viewModel: CreateDeckViewModel
//    @Binding var isPresented: Bool
//
//    var body: some View {
//        HStack(spacing: 16) {
//            Button {
//                isPresented = false
//            } label: {
//                Image(systemName: "xmark")
//                    .font(.title3)
//                    .foregroundStyle(Color(.darkGray))
//            }
//
//            Text("Новая подборка")
//                .font(.headline)
//
//            Spacer()
//
//            Button {
//                try? viewModel.save()
//                isPresented = false
//            } label: {
//                Text("Создать")
//                    .padding(6)
//                    .font(.subheadline)
//                    .overlay {
//                        RoundedRectangle(cornerRadius: 12)
//                            .stroke(lineWidth: 1)
//                    }
//                    .foregroundStyle(Color(.purple))
//            }
//        }
//    }
//}

struct CreateRowDeckView: View {
    @Bindable var card: Card
    @State private var showExampleField = false
    @State private var selectedPhoto: PhotosPickerItem?
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(spacing: 12) {
            CreateTextFieldView(placeholder: "Термин", text: $card.term, isFocused: $isFocused)
            
            Divider().frame(height: 1)
            
            CreateTextFieldView(placeholder: "Определение", text: $card.definition, isFocused: $isFocused)
            
            if showExampleField && isFocused {
                Divider()
                
                CreateTextFieldView(placeholder: "Пример использования", text: $card.example, isFocused: $isFocused)
            }
            
            if isFocused { // TODO: вынести, раздел будет расширяться в будущем
                ScrollView(.horizontal) {
                    HStack(spacing: 12) {
                        
                        Button {
                            showExampleField.toggle()
                        } label: {
                            HStack(spacing: 4) {
                                Image(systemName: "text.quote")
                                Text("Пример")
                            }
                            .padding(6)
                        }
                        .buttonStyle(.plain)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(.systemGray4), lineWidth: 1)
                        )
                        
                        
                        Button {
                            showExampleField.toggle()
                        } label: {
                            HStack(spacing: 4) {
                                Image(systemName: "text.quote")
                                Text("Синоним")
                            }
                            .padding(6)
                        }
                        .buttonStyle(.plain)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(.systemGray4), lineWidth: 1)
                        )
                        
                        PhotosPicker(selection: $selectedPhoto, matching: .images) {
                            HStack {
                                Image(systemName: "photo")
                                Text("jpg")
                            }
                        }
                        .buttonStyle(.plain)
                        .padding(6)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(.systemGray4), lineWidth: 1)
                        )
                        .onChange(of: selectedPhoto) { _, newItem in
                            Task {
                                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                    card.image = data
                                }
                            }
                        }
                        
                        Spacer()
                    }
                    .font(.caption)
                    .foregroundStyle(.black)
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(.rect(cornerRadius: 20))
    }
}

struct CreateTextFieldView: View {
    let placeholder: String
    @Binding var text: String
    var isFocused: FocusState<Bool>.Binding
    
    var body: some View {
        TextField(placeholder, text: $text, axis: .vertical)
            .frame(maxWidth: .infinity, minHeight: 50)
            .focused(isFocused)
    }
}
// FocusState<Bool>.Binding как тип параметра. Это ровно то, что "торчит" из @FocusState через $, только теперь ты можешь принять эту связку фокуса как обычный параметр и передать её дальше в .focused(...) внутри дочернего View — как обычный @Binding, только специально под фокус.

struct CreateRowsDeckView: View {
    @ObservedObject var viewModel: CreateDeckViewModel
    
    var body: some View {
        ScrollViewReader { proxy in
            List {
                ForEach(viewModel.cards, id: \.id) { card in
                    CreateRowDeckView(card: card)
                        .id(card.id)
                        .listRowInsets(EdgeInsets(top: 6, leading: 0, bottom: 6, trailing: 0))
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                withAnimation {
                                    if let currentIndex = viewModel.cards.firstIndex(where: { $0.id == card.id }) {
                                        viewModel.removeCard(at: currentIndex)
                                    }
                                }
                            } label: {
                                Label("", systemImage: "trash")
                            }
                        }
                }
                
                AddCardButtonView {
                    withAnimation {
                        viewModel.addCard()
                    }
                    if let newID = viewModel.cards.last?.id {
                        DispatchQueue.main.async {
                            withAnimation {
                                proxy.scrollTo(newID, anchor: .top)
                            }
                        }
                    }
                }
                .listRowInsets(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        }
        .scrollIndicators(.hidden)
    }
}

struct AddCardButtonView: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "plus")
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity, minHeight: 48)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(Color(.systemGray4), lineWidth: 2)
                )
        }
    }
}
