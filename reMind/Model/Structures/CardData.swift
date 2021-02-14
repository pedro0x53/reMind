//
//  CardData.swift
//  reMind
//
//  Created by Pedro Sousa on 10/02/21.
//

import Foundation

struct CardData {
    var identifier: String
    var deckID: String
    var word: String
    var meaning: String
    var nextRecallDate: String
    var creationDate: String

    init(deckID: String = "", word: String, meaning: String, nextRecallDate: String = Calendar.current.getDateString(byAdding: 1)) {
        self.identifier = UUID().uuidString
        self.deckID = deckID
        self.word = word
        self.meaning = meaning
        self.nextRecallDate = nextRecallDate
        self.creationDate = Calendar.current.getDateString(byAdding: 0)
    }
}
