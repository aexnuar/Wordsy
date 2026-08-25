//
//  CreateFolderViewModel.swift
//  Wordsy
//
//  Created by aex on 14.08.2026.
//

import Foundation
import Combine

@MainActor
final class CreateFolderViewModel: ObservableObject {
    @Published var title: String = ""
    private let repository: DeckRepositoryProtocol
    
    init(repository: DeckRepositoryProtocol) {
        self.repository = repository
    }
    
    func save() throws {
        guard !title.isEmpty else { return }
        let folder = Folder(title: title)
        repository.addFolder(folder)
    }
}
