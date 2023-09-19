//
//  ActiveRecord.swift
//  reMind
//
//  Created by Pedro Sousa on 13/07/23.
//

import Foundation

protocol Readable {
    static func find(query: String, arguments: [Any]?) -> [Self]
    static func all() -> [Self]
}

protocol Deletable {
    func destroy()
}

protocol Writeable {
    static func newObject() -> Self
}

protocol ActiveRecordType: Readable, Writeable, Deletable {}

protocol ModelType: ActiveRecordType {
    associatedtype Context
    static var context: Self.Context { get }
}
