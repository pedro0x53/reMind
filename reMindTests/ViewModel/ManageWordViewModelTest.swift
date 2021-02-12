//
//  ManageWordViewModelTest.swift
//  reMindTests
//
//  Created by Pedro Sousa on 11/02/21.
//

import XCTest
@testable import reMind

class ManageWordViewModelTest: XCTestCase {

    var sut: ManageWordViewModel!
    var repo: CardRepository!
    var mockedCardData = CardData(deckID: "MockID", word: "Mock", meaning: "Mock")

    override func setUp() {
        super.setUp()
        repo = CardRepository.inMemory
        repo.create(with: mockedCardData)
        sut = ManageWordViewModel(.inMemory)
    }

    func test_menageWordViewModel_setCardWith_create_true() {
        sut.card = nil
        sut.deckID = "MockID"
        let output = sut.setCardWith(word: "New Mocked Word (Create)", meaning: "New meaning")

        XCTAssertTrue(output)
    }

    func test_menageWordViewModel_setCardWith_update_true() {
        sut.card = repo.read(identifier: mockedCardData.identifier)
        sut.deckID = "MockID"
        let output = sut.setCardWith(word: "New Mocked Word (Update)", meaning: "New meaning")

        XCTAssertTrue(output)
    }

    func test_menageWordViewModel_deleteWord_true() {
        let data = CardData(deckID: "MockID", word: "Mock", meaning: "Mock")
        repo.create(with: data)
        sut.card = repo.read(identifier: data.identifier)

        let output = sut.deleteWord()

        XCTAssertTrue(output)
    }

    override func tearDown() {
        repo.drop()
        repo = nil
        sut = nil
        super.tearDown()
    }

}
