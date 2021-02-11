//
//  NewDeckViewModelProtocol.swift
//  reMind
//
//  Created by Pedro Sousa on 10/02/21.
//

import Foundation

protocol NewDeckViewModelProtocol {
    func createDeck(name: String, description: String, keywords: String) -> Bool
}
