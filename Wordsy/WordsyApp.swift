//
//  WordsyApp.swift
//  Wordsy
//
//  Created by aex on 31.07.2026.
//

import SwiftUI
import SwiftData

@main
struct WordsyApp: App {
    @StateObject private var container = DIContainer()
    
    var body: some Scene {
        WindowGroup {
           TabBarView()
                .environmentObject(container)
        }
    }
}
