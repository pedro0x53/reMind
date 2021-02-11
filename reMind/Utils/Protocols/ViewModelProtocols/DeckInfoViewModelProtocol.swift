//
//  DeckInfoViewModelProtocol.swift
//  reMind
//
//  Created by Pedro Sousa on 10/02/21.
//

import Foundation

protocol DeckInfoViewModelProtocol {
    associatedtype C
    associatedtype D

    var deck: D? { get set }

    func loadDataSource()
    func numberOfRows() -> Int
    func getData(for row: Int) -> C
    func getWord(for row: Int) -> String

    func deleteWord(for row: Int) -> Bool
}
