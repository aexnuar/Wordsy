//
//  CreateFolderView.swift
//  Wordsy
//
//  Created by aex on 13.08.2026.
//

import SwiftUI

struct CreateFolderView: View {
    //@Environment(\.dismiss) private var dismiss
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                // содержимое экрана
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        //dismiss()
                        isPresented = false
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
}

#Preview {
    CreateFolderView(isPresented: .constant(true))
}
