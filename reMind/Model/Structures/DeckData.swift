//
//  DeckData.swift
//  reMind
//
//  Created by Pedro Sousa on 08/02/21.
//

import Foundation

struct DeckData {
    var identifier: String
    var name: String
    var descriptionText: String
    var keywords: String
    var themeID: Int16
    var isShared: Bool

    init(name: String, description: String, keywords: String) {
        self.identifier = UUID().uuidString
        self.name = name
        self.descriptionText = description
        self.keywords = keywords
        self.themeID = Int16.random(in: 0...3)
        self.isShared = false
    }
}
