//
//  HomeViewModel.swift
//  reMind
//
//  Created by Pedro Sousa on 09/02/21.
//

import Foundation

final class HomeViewModel: HomeViewModelProtocol {
    var editingIndex: Int?

    private let repo: DeckRepository
    private var dataSource: [Deck] = []

    init(_ type: StorageType = .persistent) {
        switch type {
        case .inMemory:
            self.repo = DeckRepository.inMemory
        default:
            self.repo = DeckRepository.shared
        }
        self.loadDataSource()
    }

    func loadDataSource() {
        self.dataSource = self.repo.readAll()
    }

    func appendToDataSource(_ item: Deck) {
        self.dataSource.insert(item, at: 0)
    }
    
    func deleteFromDataSource() {
        self.dataSource.remove(at: self.editingIndex!)
    }

    func updateDataSource(with item: Deck) {
        self.dataSource.remove(at: self.editingIndex!)
        self.dataSource.insert(item, at: self.editingIndex!)
    }

    func numberOfItems() -> Int {
        return self.dataSource.count
    }
    
    func data(for item: Int) -> Deck {
        return self.dataSource[item]
    }

    func getName(for item: Int) -> String {
        return self.dataSource[item].name!
    }

    func getTheme(for item: Int) -> Int {
        return Int(self.dataSource[item].themeID)
    }
}
