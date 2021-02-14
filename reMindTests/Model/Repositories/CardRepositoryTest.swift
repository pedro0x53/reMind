//
//  CardRepositoryTest.swift
//  reMindTests
//
//  Created by Pedro Sousa on 11/02/21.
//

import XCTest
@testable import reMind

class CardRepositoryTest: XCTestCase {

    var sut: CardRepository!

    override func setUp() {
        super.setUp()
        sut = CardRepository.inMemory
    }

    func test_cardRepository_create_true() {
        let data = CardData(deckID: "MockID", word: "Test", meaning: "Teste teste")

        let output = sut.create(with: data)

        XCTAssertNotNil(output)
    }

    func test_cardRepository_readAll_3() {
        let card1 = CardData(deckID: "Mock1ID", word: "Test 1", meaning: "Teste teste 1")
        let card2 = CardData(deckID: "Mock2ID", word: "Test 2", meaning: "Teste teste 2")
        let card3 = CardData(deckID: "Mock3ID", word: "Test 3", meaning: "Teste teste 3")

        sut.create(with: card1)
        sut.create(with: card2)
        sut.create(with: card3)

        let expected = 3
        let actual = sut.readAll().count

        XCTAssertEqual(expected, actual)
    }

    func test_cardRepository_readAllForDeckID_2() {
        let deckID = "MockedID"
        let card1 = CardData(deckID: deckID, word: "Test 1", meaning: "Teste teste 1")
        let card2 = CardData(deckID: deckID, word: "Test 2", meaning: "Teste teste 2")
        let card3 = CardData(deckID: "randomID", word: "Test 3", meaning: "Teste teste 3")

        sut.create(with: card1)
        sut.create(with: card2)
        sut.create(with: card3)

        let expected = 2
        let actual = sut.readAll(forDeckID: deckID).count

        XCTAssertEqual(expected, actual)
    }

    func test_cardRepository_readAllForReview_2() {
        let deckID = "MockedID"
        let card1 = CardData(deckID: deckID, word: "Test 1", meaning: "Teste teste 1",
                             nextRecallDate: Calendar.current.getDateString(byAdding: 0))
        let card2 = CardData(deckID: deckID, word: "Test 2", meaning: "Teste teste 2",
                             nextRecallDate: Calendar.current.getDateString(byAdding: 0))
        let card3 = CardData(deckID: "randomID", word: "Test 3", meaning: "Teste teste 3",
                             nextRecallDate: Calendar.current.getDateString(byAdding: 0))

        sut.create(with: card1)
        sut.create(with: card2)
        sut.create(with: card3)

        let expected = 2
        let actual = sut.readAllForReview(forDeckID: deckID).count

        XCTAssertEqual(expected, actual)
    }

    func test_cardRepository_countForReview_2() {
        let deckID = "MockedID"
        let card1 = CardData(deckID: deckID, word: "Test 1", meaning: "Teste teste 1",
                             nextRecallDate: Calendar.current.getDateString(byAdding: 0))
        let card2 = CardData(deckID: deckID, word: "Test 2", meaning: "Teste teste 2",
                             nextRecallDate: Calendar.current.getDateString(byAdding: 0))
        let card3 = CardData(deckID: "randomID", word: "Test 3", meaning: "Teste teste 3",
                             nextRecallDate: Calendar.current.getDateString(byAdding: 0))

        sut.create(with: card1)
        sut.create(with: card2)
        sut.create(with: card3)

        let expected = 2
        let actual = sut.countForReview(forDeckID: deckID)

        XCTAssertEqual(expected, actual)
    }

    func test_cardRepository_read_notNil() {
        let data = CardData(deckID: "MockID", word: "Test", meaning: "Test test")
        let identifier = data.identifier

        sut.create(with: data)

        let output = sut.read(identifier: identifier)

        XCTAssertNotNil(output)
    }

    func test_cardRepository_read_nil() {
        let nonExistentIdentifier = "nonExistentIdentifier"

        let output = sut.read(identifier: nonExistentIdentifier)

        XCTAssertNil(output)
    }


    func test_cardRepository_update_true() {
        var data = CardData(deckID: "MockID", word: "Test", meaning: "Test test")
        let identifier = data.identifier

        sut.create(with: data)
        data.word = "NewWord"

        let record = sut.read(identifier: identifier)!

        let output = sut.update(record, with: data)

        XCTAssertTrue(output)
    }

    func test_cardRepository_delete_true() {
        let data = CardData(deckID: "MockID", word: "Word", meaning: "Meaning")
        let identifier = data.identifier
        
        sut.create(with: data)
        let output = sut.delete(identifier: identifier)

        XCTAssertTrue(output)
    }

    func test_cardRepository_deleteAllForDeckID_true() {
        let data1 = CardData(deckID: "MockID", word: "Word", meaning: "Meaning")
        let data2 = CardData(deckID: "MockID", word: "Word", meaning: "Meaning")
    
        sut.create(with: data1)
        sut.create(with: data2)
        let output = sut.deleteAll(forDeckID: "MockID")

        XCTAssertTrue(output)
    }

    func test_cardRepository_drop_true() {
        let result = sut.drop()

        XCTAssertTrue(result)
    }

    override func tearDown() {
        sut.drop()
        sut = nil
        super.tearDown()
    }

}
