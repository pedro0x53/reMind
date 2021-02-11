//
//  DeckRepository.swift
//  reMind
//
//  Created by Pedro Sousa on 08/02/21.
//

import Foundation
import CoreData

final class DeckRepository: RepositoryProtocol {
    typealias D = DeckData
    typealias E = Deck

    private let coreDataStack: CoreDataStack

    private static let entityName = "Deck"

    public static let shared: DeckRepository = DeckRepository()
    public static let inMemory: DeckRepository = DeckRepository(.inMemory)

    private init(_ storegeType: StorageType = .persistent) {
        switch storegeType {
        case .inMemory:
            self.coreDataStack = CoreDataStack.inMemory
        default:
            self.coreDataStack = CoreDataStack.shared
        }
    }
    
    @discardableResult
    func create(with data: DeckData) -> Bool {
        let managedContext = self.coreDataStack.managedContext

        let deck = Deck(context: managedContext)
        deck.identifier = data.identifier
        deck.ownerID = nil
        deck.name = data.name
        deck.descriptionText = data.descriptionText
        deck.keywords = data.keywords
        deck.isShared = data.isShared
        deck.themeID = data.themeID
        
        return self.saveContext()
    }
    
    func readAll() -> [Deck] {
        let managedContext = self.coreDataStack.managedContext
        let request = NSFetchRequest<Deck>(entityName: DeckRepository.entityName)
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]

        do {
            return try managedContext.fetch(request)
        } catch let error as NSError {
            print("DeckRepository Error - Unresolved error \(error), \(error.userInfo)")
            return []
        }
    }
    
    func read(identifier: String) -> Deck? {
        let managedContext = self.coreDataStack.managedContext
        let request = NSFetchRequest<Deck>(entityName: DeckRepository.entityName)
        request.predicate = NSPredicate(format: "identifier == %@", identifier)

        return try? managedContext.fetch(request).first
    }
    
    func update(_ entity: Deck, with data: DeckData) -> Bool {
        entity.name = data.name
        entity.descriptionText = data.descriptionText
        entity.keywords = data.keywords
        entity.themeID = data.themeID
        
        return self.saveContext()
    }

    @discardableResult
    func delete(identifier: String) -> Bool {
        let record = self.read(identifier: identifier)
        
        if let record = record {
            self.coreDataStack.managedContext.delete(record)
        }

        return self.saveContext()
    }

    @discardableResult
    func drop() -> Bool {
        let allRecords = self.readAll()
        for record in allRecords {
            self.coreDataStack.managedContext.delete(record)
        }
        return self.saveContext()
    }

    @discardableResult
    func saveContext() -> Bool {
        return self.coreDataStack.saveContext()
    }
    
}
