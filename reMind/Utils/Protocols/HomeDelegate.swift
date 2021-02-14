//
//  DataSourceOwnerDelegate.swift
//  reMind
//
//  Created by Pedro Sousa on 14/02/21.
//

import Foundation

protocol HomeDelegate: class {
    func updateCollection(with item: Deck?)

    func error()
}
