//
//  LibraryFolderView.swift
//  Wordsy
//
//  Created by aex on 13.08.2026.
//

import SwiftUI

struct LibraryFolderView: View {
    let folder: Folder
    
    var body: some View {
        NavigationLink(destination: Text("Экран папки")) {
            HStack(spacing: 12) {
                Image(systemName: "folder.fill")
                    .font(.callout)
                    .foregroundStyle(.white)
                    .frame(width: 40, height: 40)
                    .background(
                        LinearGradient(
                            colors: [.orange, .yellow],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 3) {
                    Text(folder.title)
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundStyle(.primary)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    
                    Text("Папка")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
            }
            .frame(height: 76)
            .padding(.horizontal, 16)
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
        }
        .buttonStyle(ScaleButtonStyle())
        .hapticTap()
    }
}
