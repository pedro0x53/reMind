//
//  ManageWordViewModel.swift
//  reMind
//
//  Created by Pedro Sousa on 11/02/21.
//

import Foundation

final class ManageWordViewModel: ManageWordViewModelProtocol {

    var card: Card?

    var deckID: String?

    private let repo: CardRepository

    init(_ type: StorageType = .persistent) {
        switch type {
        case .inMemory:
            self.repo = CardRepository.inMemory
        default:
            self.repo = CardRepository.shared
        }
    }
    
    func setCardWith(word: String, meaning: String) -> Card? {
        if let card = self.card {
            let data = CardData(word: word, meaning: meaning)
            if self.repo.update(card, with: data) {
                return card
            }
        } else {
            if let deckID = self.deckID {
                let data = CardData(deckID: deckID, word: word, meaning: meaning)
                return self.repo.create(with: data)
            }
        }
        return nil
    }

    @discardableResult
    func deleteWord() -> Bool {
        guard let card = self.card else { return true }
        return self.repo.delete(identifier: card.identifier!)
    }
}
