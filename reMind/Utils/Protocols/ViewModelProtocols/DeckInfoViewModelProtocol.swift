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

    var editingIndex: Int? { get set }

    func loadDataSource()
    func appendToDataSource(_ item: Card)
    func updateDataSource(with item: Card)
    func deleteFromDataSource()

    func numberOfRows() -> Int

    func getReviewNumber() -> Int
    func getThemeID() -> Int
    func getTitle() -> String
    func getData(for row: Int) -> C
    func getWord(for row: Int) -> String
}
