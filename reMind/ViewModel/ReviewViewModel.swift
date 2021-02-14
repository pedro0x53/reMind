//
//  ReviewViewModel.swift
//  reMind
//
//  Created by Pedro Sousa on 11/02/21.
//

import Foundation

final class ReviewViewModel: ReviewViewModelProtocol {

    var deckID: String? {
        didSet {
            self.loadDataSource()
        }
    }

    private var dataSourece: [Card] = []

    private let repo: CardRepository

    init(_ type: StorageType = .persistent) {
        switch type {
        case .inMemory:
            self.repo = CardRepository.inMemory
        default:
            self.repo = CardRepository.shared
        }
    }

    func loadDataSource() {
        if let deckID = deckID {
            self.dataSourece = self.repo.readAllForReview(forDeckID: deckID)
        }
    }

    func getCardContent() -> (word: String, meaning: String)? {
        guard let first = self.dataSourece.first else { return nil }

        guard let word = first.word else { return nil }
        guard let meaning = first.meaning else { return nil }

        return (word: word, meaning: meaning)
    }

    @discardableResult
    func updateNextRecall(remembered: Bool) -> Bool {
        guard let card = self.dataSourece.first else { return true }

        _ = self.dataSourece.removeFirst()

        if card.recall >= 0 && card.recall < 7 {
            if remembered {
                card.recall += 1
            } else {
                card.recall -= 1
            }
        }

        card.nextRecallDate = Calendar.current.getDateString(byAdding: Int(card.recall))

        return self.repo.saveContext()
    }
}
