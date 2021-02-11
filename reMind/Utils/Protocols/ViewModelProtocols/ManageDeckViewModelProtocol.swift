//
//  ManageDeckViewModelProtocol.swift
//  reMind
//
//  Created by Pedro Sousa on 10/02/21.
//

import Foundation

protocol ManageDeckViewModelProtocol {
    var deck: Deck? { get set }
    
    func setDeckWith(name: String, description: String, keywords: String) -> Bool
}
