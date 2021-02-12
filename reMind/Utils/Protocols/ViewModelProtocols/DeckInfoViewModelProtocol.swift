//
//  DeckInfoViewModelProtocol.swift
//  reMind
//
//  Created by Pedro Sousa on 10/02/21.
//

import Foundation

protocol DeckInfoViewModelProtocol {
    associatedtype C

    var deck: Deck? { get set }

    func loadDataSource()
    func numberOfRows() -> Int
    func getReviewNumber() -> Int
    func getThemeID() -> Int
    func getTitle() -> String

    func getData(for row: Int) -> C
    func getWord(for row: Int) -> String

    func deleteWord(for row: Int) -> Bool
}
