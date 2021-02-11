//
//  DeckInfoViewModelTest.swift
//  reMindTests
//
//  Created by Pedro Sousa on 11/02/21.
//

import XCTest
@testable import reMind

class DeckInfoViewModelTest: XCTestCase {

    var sut: DeckInfoViewModel!

    var cardRepo: CardRepository!
    var deckRepo: DeckRepository!

    var mockedDeckData = DeckData(name: "Mock", description: "Mocked deck", keywords: "mock")

    override func setUp() {
        super.setUp()
        cardRepo = CardRepository.inMemory

        deckRepo = DeckRepository.inMemory
        deckRepo.create(with: mockedDeckData)
        
        let card1 = CardData(deckID: mockedDeckData.identifier, word: "Word 1", meaning: "Meaning 1")
        let card2 = CardData(deckID: mockedDeckData.identifier, word: "Word 2", meaning: "Meaning 2")
        let card3 = CardData(deckID: mockedDeckData.identifier, word: "Word 3", meaning: "Meaning 3")

        cardRepo.create(with: card1)
        cardRepo.create(with: card2)
        cardRepo.create(with: card3)

        sut = DeckInfoViewModel(.inMemory)
        sut.deck = deckRepo.read(identifier: mockedDeckData.identifier)
    }

    func test_deckInfoViewModel_numberOfRows_3() {
        let expected = 3

        let actual = sut.numberOfRows()

        XCTAssertEqual(expected, actual)
    }

    func test_deckInfoViewModel_getWord_true() {
        let expeted = "Word 1"

        let actual = sut.getWord(for: 0)

        XCTAssertEqual(expeted, actual)
    }

    func test_deckInfoViewModel_deleteWord_true() {
        let output = sut.deleteWord(for: 0)

        let card1 = CardData(deckID: mockedDeckData.identifier, word: "Word 1", meaning: "Meaning 1")
        cardRepo.create(with: card1)

        XCTAssertTrue(output)
    }

    func test_deckInfoViewModel_deleteWord_false() {
        let output = sut.deleteWord(for: 10)

        XCTAssertFalse(output)
    }

    override func tearDown() {
        deckRepo.drop()
        deckRepo = nil

        cardRepo.drop()
        cardRepo = nil

        sut = nil
        super.tearDown()
    }

}
