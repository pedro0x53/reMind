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

    var hasEdits: Bool = false

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

    func reloadDeck() {
        if let deck = self.deck {
            self.deck = self.deckRepo.read(identifier: deck.identifier!)
            self.hasEdits = true
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

    func getTitle() -> String {
        return self.deck?.name ?? "Deck"
    }

    func getReviewNumber() -> Int {
        guard let identifier = self.deck?.identifier else { return 0 }
        return self.cardRepo.countForReview(forDeckID: identifier)
    }

    func getThemeID() -> Int {
        guard let themeID = self.deck?.themeID else { return 0 }
        return Int(themeID)
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
