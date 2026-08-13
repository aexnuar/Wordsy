//
//  LibraryTabView.swift
//  Wordsy
//
//  Created by aex on 13.08.2026.
//

import SwiftUI

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
