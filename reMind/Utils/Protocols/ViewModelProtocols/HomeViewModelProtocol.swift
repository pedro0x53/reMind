//
//  HomeViewModelProtocol.swift
//  reMind
//
//  Created by Pedro Sousa on 09/02/21.
//

import Foundation

protocol HomeViewModelProtocol {
    var editingIndex: Int? { get set }

    func loadDataSource()
    func appendToDataSource(_ item: Deck)
    func updateDataSource(with item: Deck)
    func deleteFromDataSource()

    func numberOfItems() -> Int
    func data(for item: Int) -> Deck

    func getName(for item: Int) -> String
    func getTheme(for item: Int) -> Int
}
