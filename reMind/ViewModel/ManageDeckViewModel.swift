//
//  NewDeckViewModel.swift
//  reMind
//
//  Created by Pedro Sousa on 10/02/21.
//

import Foundation

final class ManageDeckViewModel: ManageDeckViewModelProtocol {
    private let deckRepo: DeckRepository
    private let cardRepo: CardRepository

    var deck: Deck?

    init(_ type: StorageType = .persistent) {
        switch type {
        case .inMemory:
            self.deckRepo = DeckRepository.inMemory
            self.cardRepo = CardRepository.inMemory
        default:
            self.deckRepo = DeckRepository.shared
            self.cardRepo = CardRepository.shared
        }
    }

    func setDeckWith(name: String, description: String, keywords: String, themeID: Int) -> Bool {
        let data = DeckData(name: name, description: description, keywords: keywords, themeID: themeID)
        if let deck = self.deck {
            return self.deckRepo.update(deck, with: data)
        }
        return self.deckRepo.create(with: data)
    }

    @discardableResult
    func deleteDeck() -> Bool {
        guard let identifier = self.deck?.identifier else { return true }
        self.deck = nil
        return self.deckRepo.delete(identifier: identifier) && self.cardRepo.deleteAll(forDeckID: identifier)
    }
}
