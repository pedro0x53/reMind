//
//  CoreDataStack.swift
//  FlashCards
//
//  Created by Pedro Sousa on 21/10/20.
//

import UIKit
import CoreData

enum StorageType {
    case persistent, inMemory
}

class CoreDataStack {
    public static let shared = CoreDataStack(.persistent)
    public static let inMemory = CoreDataStack(.inMemory)

    private static let modelName: String = "ReMind"

    private var persistentContainer: NSPersistentContainer

    private(set) lazy var managedContext: NSManagedObjectContext = {
      return self.persistentContainer.viewContext
    }()

    init(_ storageType: StorageType = .persistent) {
        self.persistentContainer = NSPersistentContainer(name: CoreDataStack.modelName)
        
        if storageType == .inMemory {
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType
            self.persistentContainer.persistentStoreDescriptions = [description]
        }

        self.persistentContainer.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                print("CoreDataStack Error - Unresolved error \(error), \(error.userInfo)")
            }
        }
    }


    @discardableResult
    func saveContext() -> Bool {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                return true
            } catch let error as NSError {
                print("CoreDataStack Error - Unresolved error \(error), \(error.userInfo)")
                return false
            }
        }
        return true
    }
}
