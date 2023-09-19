//
//  Term.swift
//  reMind
//
//  Created by Pedro Sousa on 03/07/23.
//

import SwiftUI

extension Term: CoreDataModel {
    var srs: SpacedRepetitionSystem {
        return SpacedRepetitionSystem(rawValue: Int(rawSRS)) ?? SpacedRepetitionSystem.first
    }

    var theme: reTheme {
        return reTheme(rawValue: Int(self.rawTheme)) ?? reTheme.lavender
    }
}

enum SpacedRepetitionSystem: Int {
    case none = 0
    case first = 1
    case second = 2
    case third = 3
    case fourth = 5
    case fifth = 8
    case sixth = 13
    case seventh = 21
}
