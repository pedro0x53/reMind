//
//  ManageWordViewModelProtocol.swift
//  reMind
//
//  Created by Pedro Sousa on 11/02/21.
//

import Foundation

protocol ManageWordViewModelProtocol {
    var card: Card? { get set }
    
    func setCardWith(word: String, meaning: String) -> Bool
    func deleteWord() -> Bool
}
