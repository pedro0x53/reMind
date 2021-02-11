//
//  NewDeckViewModel.swift
//  reMind
//
//  Created by Pedro Sousa on 10/02/21.
//

import Foundation

final class ManageDeckViewModel: ManageDeckViewModelProtocol {
    private let repo: DeckRepository

    var deck: Deck?

    init(_ type: StorageType = .persistent) {
        switch type {
        case .inMemory:
            self.repo = DeckRepository.inMemory
        default:
            self.repo = DeckRepository.shared
        }
    }

    func setDeckWith(name: String, description: String, keywords: String) -> Bool {
        if let deck = self.deck {
            let data = DeckData(name: name, description: description, keywords: keywords)
            return self.repo.update(deck, with: data)
        }
        let data = DeckData(name: name, description: description, keywords: keywords)
        return self.repo.create(with: data)
    }
}
