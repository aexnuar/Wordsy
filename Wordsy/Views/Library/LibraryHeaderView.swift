//
//  LibraryHeaderView.swift
//  Wordsy
//
//  Created by aex on 13.08.2026.
//

import SwiftUI

struct LibraryHeaderView: View {
    var body: some View {
        HStack {
            Text("Библиотека")
                .font(.title)
                .bold()
            
            Spacer()
            
            Button {
                //
            } label: {
                Image(systemName: "ellipsis.circle")
                    .font(.title3)
                    .foregroundStyle(Color(.darkGray))
            }
        }
    }
}

#Preview {
    LibraryHeaderView()
}
