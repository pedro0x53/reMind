//
//  NewDeckViewModelTest.swift
//  reMindTests
//
//  Created by Pedro Sousa on 10/02/21.
//

import XCTest
@testable import reMind

class NewDeckViewModelTest: XCTestCase {

    var sut: NewDeckViewModel!

    override func setUp() {
        super.setUp()
        sut = NewDeckViewModel(.inMemory)
    }

    func test_newDeckViewModel_create_true() {
        let output = sut.createDeck(name: "Teste", description: "Teste teste", keywords: "teste, teste")

        XCTAssertTrue(output)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}
