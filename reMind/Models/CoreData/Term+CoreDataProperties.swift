//
//  Term+CoreDataProperties.swift
//  reMind
//
//  Created by Pedro Sousa on 19/09/23.
//
//

import Foundation
import CoreData


extension Term {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Term> {
        return NSFetchRequest<Term>(entityName: "Term")
    }

    @NSManaged public var creationDate: Date?
    @NSManaged public var identifier: UUID?
    @NSManaged public var lastReview: Date?
    @NSManaged public var meaning: String?
    @NSManaged public var rawSRS: Int16
    @NSManaged public var rawTheme: Int16
    @NSManaged public var value: String?
    @NSManaged public var boxID: Box?

}

extension Term : Identifiable {

}
