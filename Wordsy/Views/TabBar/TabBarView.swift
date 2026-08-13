//
//  TabBarView.swift
//  Wordsy
//
//  Created by aex on 06.08.2026.
//

import Foundation
import SwiftUI

enum AppTab {
    case home, library, add
}

struct TabBarView: View {
    @EnvironmentObject private var container: DIContainer
    @State private var selectedTab: AppTab = .home
    @State private var previousTab: AppTab = .home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Главная", systemImage: "house", value: .home) {
                NavigationStack {
                    HomeView(viewModel: container.makeHomeViewModel())
                }
            }
            
            Tab("Библиотека", systemImage: "book", value: .library) {
                NavigationStack {
                    LibraryView(viewModel: container.makeLibraryViewModel())
                }
            }
            
            Tab("Создать", systemImage: "plus", value: .add) {
                //Color.clear
            }
        }
        .onChange(of: selectedTab) { oldValue, newValue in
            if newValue == .add {
                previousTab = oldValue
            }
        }
        .sheet(isPresented: Binding(
            get: { selectedTab == .add },
            set: { isPresented in
                if !isPresented {
                    selectedTab = previousTab
                }
            }
        )) {
            AddView()
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    TabBarView()
        .environmentObject(DIContainer())
}
