//
//  CoreDataStackTest.swift
//  reMindTests
//
//  Created by Pedro Sousa on 09/02/21.
//

import XCTest
@testable import reMind

class CoreDataStackTest: XCTestCase {

    func test_coreDataStack_saveContext_true() {
        // Given
        let sut = CoreDataStack(.inMemory)

        // When
        let result = sut.saveContext()

        // Then
        XCTAssertTrue(result)
    }
}
