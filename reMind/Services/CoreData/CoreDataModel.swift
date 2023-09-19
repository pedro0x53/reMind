//
//  CoreDataModel.swift
//  reMind
//
//  Created by Pedro Sousa on 13/07/23.
//

import Foundation
import CoreData

protocol CoreDataModel: ModelType {
    associatedtype Context = NSManagedObjectContext
}

extension CoreDataModel where Self: NSManagedObject {
    static var context: NSManagedObjectContext {
        return CoreDataStack.inMemory.managedContext
    }

    static func newObject() -> Self {
        return self.init(context: context)
    }

    func destroy() {
        Self.context.delete(self)
    }

    static func all() -> [Self] {
        let request = NSFetchRequest<Self>(entityName: self.className)
        guard let result = try? context.fetch(request) else {
            return [] }
        return result
    }

    static func find(query: String, arguments: [Any]? = nil) -> [Self] {
        let query = NSPredicate(format: query, argumentArray: arguments)
        let request = NSFetchRequest<Self>(entityName: self.className)
        request.predicate = query
        guard let result = try? context.fetch(request) else { return [] }
        return result
    }
}
