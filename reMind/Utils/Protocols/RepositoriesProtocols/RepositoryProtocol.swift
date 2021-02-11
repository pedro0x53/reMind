//
//  RespositoryProtocol.swift
//  reMind
//
//  Created by Pedro Sousa on 08/02/21.
//

import Foundation

protocol RepositoryProtocol {
    associatedtype D
    associatedtype E

    func create(with data: D) -> Bool
    func readAll() -> [E]
    func read(identifier: String) -> E?
    func update(_ entity: E, with data: D) -> Bool
    func delete(identifier: String) -> Bool
    func drop() -> Bool
}

protocol CardsRepositoryProtocol: RepositoryProtocol {
    func readAll(forDeckID deckID: String) -> [E]
    func readAllForReview(forDeckID deckID: String) -> [E]
    func countForReview(forDeckID deckID: String) -> Int
}
