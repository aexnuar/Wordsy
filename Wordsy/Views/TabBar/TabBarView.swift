//
//  TabBarView.swift
//  Wordsy
//
//  Created by aex on 06.08.2026.
//

import Foundation
import SwiftUI

//enum AppTab {
//    case home, library, add
//}

struct TabBarView: View {
    @EnvironmentObject private var container: DIContainer
        //@State private var selectedTab: AppTab = .home
    
    var body: some View {
        TabView/*(selection: $selectedTab)*/ {
            Tab("Главная", systemImage: "circle"/*, value: .home*/) {
                NavigationStack {
                    HomeView(viewModel: container.makeHomeViewModel()/*, selectedTab: $selectedTab*/)
                }
            }
            
            Tab("Библиотека", systemImage: "book"/*, value: .library*/) {
                NavigationStack {
                    LibraryView(viewModel: container.makeLibraryViewModel())
                }
            }
            
            Tab("Создать", systemImage: "plus"/*, value: .add*/) {
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
