//
//  CreateScreenHeaderView.swift
//  Wordsy
//
//  Created by aex on 19.08.2026.
//

import SwiftUI

struct CreateScreenHeaderView: View {
    @Binding var isPresented: Bool
    let title: String
    let onSave: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            Button {
                isPresented = false
            } label: {
                Image(systemName: "xmark")
                    .font(.title3)
                    .foregroundStyle(Color(.darkGray))
            }
            
            Text(title)
                .font(.headline)
            
            Spacer()
            
            Button {
                onSave()
                isPresented = false
            } label: {
                Text("Создать")
                    .padding(6)
                    .font(.subheadline)
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(lineWidth: 1)
                    }
                    .foregroundStyle(Color(.purple))
            }
        }
    }
}

#Preview {
    CreateScreenHeaderView(isPresented: .constant(true), title: "Title") {
        //
    }
}


