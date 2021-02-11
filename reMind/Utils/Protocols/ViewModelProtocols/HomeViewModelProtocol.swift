//
//  HomeViewModelProtocol.swift
//  reMind
//
//  Created by Pedro Sousa on 09/02/21.
//

import Foundation

protocol HomeViewModelProtocol {
    associatedtype D

    func loadDataSource()
    func numberOfItems() -> Int
    func data(for item: Int) -> D

    func getName(for item: Int) -> String
    func getTheme(for item: Int) -> Int
}
