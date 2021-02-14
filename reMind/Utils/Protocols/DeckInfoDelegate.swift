//
//  DeckInfoDelegate.swift
//  reMind
//
//  Created by Pedro Sousa on 14/02/21.
//

import Foundation

protocol DeckInfoDelegate: class {
    func updateTable(with item: Card?)
    func updateInfo(with deck: Deck)
    func updateReviewCard()

    func deleted()

    func error()
}
