//
//  DeckRepositoryTest.swift
//  reMindTests
//
//  Created by Pedro Sousa on 08/02/21.
//

import XCTest
@testable import reMind

class DeckRepositoryTest: XCTestCase {

    var sut: DeckRepository!
    var data: DeckData!

    override func setUp() {
        super.setUp()
        sut = DeckRepository.inMemory
        data = DeckData(name: "Teste", description: "Teste teste", keywords: "teste, teste")
    }

    func test_deckRepository_create_true() {
        let result = sut.create(with: data)

        XCTAssertTrue(result)
    }

    func test_deckRepository_readAll_3() {
        let deck1 = DeckData(name: "Teste1", description: "Teste teste", keywords: "teste, teste")
        let deck2 = DeckData(name: "Teste2", description: "Teste teste", keywords: "teste, teste")
        let deck3 = DeckData(name: "Teste3", description: "Teste teste", keywords: "teste, teste")

        sut.create(with: deck1)
        sut.create(with: deck2)
        sut.create(with: deck3)

        let expected = 3
        let actual = sut.readAll().count
        
        XCTAssertEqual(expected, actual)
    }

    func test_deckRepository_read_notNil() {
        let identifier = data.identifier
        
        sut.create(with: data)
        let output = sut.read(identifier: identifier)

        XCTAssertNotNil(output)
    }

    func test_deckRepository_read_nil() {
        let nonExistentIdentifier = "nonExistentIdentifier"

        let output = sut.read(identifier: nonExistentIdentifier)

        XCTAssertNil(output)
    }

    func test_deckRepository_update_true() {
        let identifier = data.identifier
        
        sut.create(with: data)
        
        let record = sut.read(identifier: identifier)!
        data.name = "NewName"
        
        let output = sut.update(record, with: data)
        
        XCTAssertTrue(output)
        
    }

    func test_deckRepository_delete_true() {
        let identifier = data.identifier

        sut.create(with: data)
        
        let output = sut.delete(identifier: identifier)

        XCTAssertTrue(output)
    }

    func deckRepository_drop_true() {
        let result = sut.drop()

        XCTAssertTrue(result)
    }

    override func tearDown() {
        sut.drop()
        sut = nil
        super.tearDown()
    }

}
