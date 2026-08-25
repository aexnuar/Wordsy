//
//  LibraryViewModel.swift
//  Wordsy
//
//  Created by aex on 06.08.2026.
//

import Foundation
import Combine

enum LibraryType {
    case mine, community
}

@MainActor
final class LibraryViewModel: ObservableObject {
    @Published private(set) var myFolders: [Folder] = []
    @Published private(set) var myDecks: [Deck] = []
    @Published private(set) var communityDecks: [Deck] = []
    
    private let repository: DeckRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(repository: DeckRepositoryProtocol) {
        self.repository = repository
        
        repository.decksPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] decks in
                self?.myDecks = decks.filter { !$0.isPublic && $0.folder == nil }
                self?.communityDecks = decks.filter { $0.isPublic }
            }
            .store(in: &cancellables)
        
        repository.foldersPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] folders in
                self?.myFolders = folders
            }
            .store(in: &cancellables)
    }
}
