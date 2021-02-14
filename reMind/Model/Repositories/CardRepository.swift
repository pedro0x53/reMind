//
//  CardRepository.swift
//  reMind
//
//  Created by Pedro Sousa on 10/02/21.
//

import Foundation
import CoreData

final class CardRepository: CardsRepositoryProtocol {
    
    typealias D = CardData
    typealias E = Card

    private let coreDataStack: CoreDataStack

    private static let entityName = "Card"

    public static let shared: CardRepository = CardRepository()
    public static let inMemory: CardRepository = CardRepository(.inMemory)

    private init(_ storegeType: StorageType = .persistent) {
        switch storegeType {
        case .inMemory:
            self.coreDataStack = CoreDataStack.inMemory
        default:
            self.coreDataStack = CoreDataStack.shared
        }
    }

    @discardableResult
    func create(with data: CardData) -> Card? {
        
        let managedContext = self.coreDataStack.managedContext

        let card = Card(context: managedContext)
        card.identifier = data.identifier
        card.deckIdentifier = data.deckID
        card.word = data.word
        card.meaning = data.meaning
        card.recall = 0
        card.nextRecallDate = data.nextRecallDate
        card.creationDate = Date()

        if self.saveContext() {
            return card
        }

        return nil
    }

    func readAll() -> [Card] {
        let managedContext = self.coreDataStack.managedContext

        let request = NSFetchRequest<Card>(entityName: CardRepository.entityName)
        request.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        do {
            return try managedContext.fetch(request)
        } catch let error as NSError {
            print("CardRepository.readAll() Error - Unresolved error \(error), \(error.userInfo)")
            return []
        }
    }

    func readAll(forDeckID deckID: String) -> [Card] {
        let managedContext = self.coreDataStack.managedContext

        let request = NSFetchRequest<Card>(entityName: CardRepository.entityName)
        request.predicate = NSPredicate(format: "deckIdentifier == %@", deckID)
        request.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        do {
            return try managedContext.fetch(request)
        } catch let error as NSError {
            print("CardRepository.readAll(forDeckID deckID: String) Error - Unresolved error \(error), \(error.userInfo)")
            return []
        }
    }

    func readAllForReview(forDeckID deckID: String) -> [Card] {
        let managedContext = self.coreDataStack.managedContext

        let request = NSFetchRequest<Card>(entityName: CardRepository.entityName)
            request.predicate = NSPredicate(format: "deckIdentifier == %@ AND nextRecallDate == %@",
                                            deckID, Calendar.current.getDateString(byAdding: 0))

        do {
            return try managedContext.fetch(request)
        } catch let error as NSError {
            print("CardRepository.countForReview(forDeckID deckID: String) Error - Unresolved error \(error), \(error.userInfo)")
            return []
        }
    }

    func countForReview(forDeckID deckID: String) -> Int {
        let managedContext = self.coreDataStack.managedContext

        let request = NSFetchRequest<Card>(entityName: CardRepository.entityName)
            request.predicate = NSPredicate(format: "deckIdentifier == %@ AND nextRecallDate == %@",
                                            deckID, Calendar.current.getDateString(byAdding: 0))

        do {
            return try managedContext.count(for: request)
        } catch let error as NSError {
            print("CardRepository.countForReview(forDeckID deckID: String) Error - Unresolved error \(error), \(error.userInfo)")
            return 0
        }
    }

    func read(identifier: String) -> Card? {
        let managedContext = self.coreDataStack.managedContext

        let request = NSFetchRequest<Card>(entityName: CardRepository.entityName)
            request.predicate = NSPredicate(format: "identifier == %@", identifier)

        return try? managedContext.fetch(request).first
    }

    func update(_ entity: Card, with data: CardData) -> Bool {
        entity.word = data.word
        entity.meaning = data.meaning
        
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
    func deleteAll(forDeckID deckID: String) -> Bool {
        let managedContext = self.coreDataStack.managedContext
        let records = readAll(forDeckID: deckID)
        for record in records {
            managedContext.delete(record)
        }

        return self.saveContext()
    }

    @discardableResult
    func drop() -> Bool {
        let managedContext = self.coreDataStack.managedContext
        let records = self.readAll()
        for record in records {
            managedContext.delete(record)
        }

        return self.saveContext()
    }

    @discardableResult
    func saveContext() -> Bool {
        return self.coreDataStack.saveContext()
    }
}
