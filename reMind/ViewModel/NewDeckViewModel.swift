//
//  NewDeckViewModel.swift
//  reMind
//
//  Created by Pedro Sousa on 10/02/21.
//

import Foundation

final class NewDeckViewModel: NewDeckViewModelProtocol {

    private let repo: DeckRepository

    init(_ type: StorageType = .persistent) {
        switch type {
        case .inMemory:
            self.repo = DeckRepository.inMemory
        default:
            self.repo = DeckRepository.shared
        }
    }

    func createDeck(name: String, description: String, keywords: String) -> Bool {
        let deckData = DeckData(name: name, description: description, keywords: keywords)
        return self.repo.create(with: deckData)
    }
    
}
