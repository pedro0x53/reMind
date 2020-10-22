//
//  CoreDataManager.swift
//  FlashCards
//
//  Created by Pedro Sousa on 21/10/20.
//

import UIKit
import CoreData

class CoreDataManager {
    
    private var delegate: AppDelegate
    public static let shared = CoreDataManager()
    
    private init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("CoreDataManager - Initialization Error")
        }
        self.delegate = appDelegate
    }

    @discardableResult
    public func createFlashCard(term: String, meaning: String) -> Bool {
        let context = self.delegate.persistentContainer.viewContext
        
        if let entity = NSEntityDescription.entity(forEntityName: "FlashCard", in: context) {
            let flashCard = NSManagedObject(entity: entity, insertInto: context)
            
            flashCard.setValue(term, forKey: "term")
            flashCard.setValue(meaning, forKey: "meaning")
            flashCard.setValue(1, forKey: "recall")

            return self.delegate.saveContext()
        } else {
            print("CoreDataManager.createFlashCard - Wrong entity name")
            return false
        }
    }

    public func readAllFlashCards() -> [NSManagedObject] {
        let context = self.delegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSManagedObject>(entityName: "FlashCard")
        do {
            return try context.fetch(request)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }

    @discardableResult
    public func updateContext() -> Bool {
        return self.delegate.saveContext()
    }

    public func rollBackContext() {
        self.delegate.rollBackcontext()
    }

    @discardableResult
    public func deleteFlashCard(_ object: NSManagedObject) -> Bool {
        let context = self.delegate.persistentContainer.viewContext
        context.delete(object)
        return self.delegate.saveContext()
    }
    
}
