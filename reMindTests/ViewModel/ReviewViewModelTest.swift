//
//  ReviewViewModelTest.swift
//  reMindTests
//
//  Created by Pedro Sousa on 11/02/21.
//

import XCTest
@testable import reMind

class ReviewViewModelTest: XCTestCase {

    var sut: ReviewViewModel!
    var repo: CardRepository!

    let card1 = CardData(deckID: "MockID", word: "Word 1",
                         meaning: "Meaning 1", nextRecallDate: Calendar.current.getDateString(byAdding: 0))
    let card2 = CardData(deckID: "MockID", word: "Word 2",
                         meaning: "Meaning 2", nextRecallDate: Calendar.current.getDateString(byAdding: 0))
    let card3 = CardData(deckID: "MockID", word: "Word 3", meaning: "Meaning 3")

    override func setUp() {
        super.setUp()

        repo = CardRepository.inMemory

        repo.create(with: card1)
        repo.create(with: card2)
        repo.create(with: card3)
        
        sut = ReviewViewModel(.inMemory)
        sut.deckID = "MockID"
    }

    func test_reviewViewModel_getNexCardContent_notNil() {
        let output = sut.getNexCardContent()

        XCTAssertNotNil(output)
    }

    func test_reviewViewModel_getNexCardContent_nil() {
        repo.drop()

        sut = ReviewViewModel(.inMemory)
        sut.deckID = "MockID"

        let output = sut.getNexCardContent()

        XCTAssertNil(output)
    }

    func test_reviewViewModel_updateNextRecall_true() {
        repo.create(with: card1)

        let output = sut.updateNextRecall()

        XCTAssertTrue(output)
    }

    override func tearDown() {
        repo.drop()
        repo = nil
        sut = nil
        super.tearDown()
    }
}
