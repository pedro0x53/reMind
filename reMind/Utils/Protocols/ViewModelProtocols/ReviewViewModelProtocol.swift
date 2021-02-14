//
//  ReviewViewModelProtocol.swift
//  reMind
//
//  Created by Pedro Sousa on 11/02/21.
//

import Foundation

protocol ReviewViewModelProtocol {
    func loadDataSource()
    func getCardContent() -> (word: String, meaning: String)?
    func updateNextRecall(remembered: Bool) -> Bool
}
