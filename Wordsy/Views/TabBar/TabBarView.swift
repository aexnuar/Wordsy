//
//  TabBarView.swift
//  Wordsy
//
//  Created by aex on 06.08.2026.
//

import Foundation
import SwiftUI

struct TabBarView: View {
    @EnvironmentObject private var container: DIContainer
    
    var body: some View {
        TabView {
            Tab("Главная", systemImage: "circle") {
                NavigationStack {
                    HomeView(viewModel: container.makeHomeViewModel())
                }
            }
            
            Tab("Библиотека", systemImage: "book") {
                NavigationStack {
                    LibraryView(viewModel: container.makeLibraryViewModel())
                }
            }
            
            Tab("Создать", systemImage: "plus") {
                NavigationStack {
                    AddView()
                }
            }
        }
    }
}

#Preview {
    TabBarView()
        .environmentObject(DIContainer())
}
