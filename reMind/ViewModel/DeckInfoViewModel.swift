//
//  DeckInfoViewModel.swift
//  reMind
//
//  Created by Pedro Sousa on 10/02/21.
//

import Foundation

final class DeckInfoViewModel: DeckInfoViewModelProtocol {
    typealias C = Card
    typealias D = Deck

    var deck: Deck? {
        didSet {
            self.loadDataSource()
        }
    }

    private var dataSource: [Card] = []

    var reviewCout: Int = 0
    
    private let deckRepo: DeckRepository
    private let cardRepo: CardRepository

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

    func loadDataSource() {
        if let deck = self.deck {
            self.dataSource = cardRepo.readAll(forDeckID: deck.identifier!)
        }
    }
    
    func numberOfRows() -> Int {
        return self.dataSource.count
    }
    
    func getData(for row: Int) -> Card {
        return self.dataSource[row]
    }
    
    func getWord(for row: Int) -> String {
        return self.dataSource[row].word!
    }

    func deleteWord(for row: Int) -> Bool {
        if row < self.dataSource.count, let identifier = self.dataSource[row].identifier {
            if self.cardRepo.delete(identifier: identifier) {
                self.dataSource.remove(at: row)
                return true
            }
        }
        return false
    }
}
