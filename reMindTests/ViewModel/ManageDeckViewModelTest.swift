//
//  ManageDeckViewModel.swift
//  reMindTests
//
//  Created by Pedro Sousa on 10/02/21.
//

import XCTest
@testable import reMind

class ManageDeckViewModelTest: XCTestCase {

    var sut: ManageDeckViewModel!
    var repo: DeckRepository!
    var mockedDeckData = DeckData(name: "Mock", description: "Mocked deck", keywords: "mock", themeID: 0)

    override func setUp() {
        super.setUp()
        repo = DeckRepository.inMemory
        repo.create(with: mockedDeckData)

        sut = ManageDeckViewModel(.inMemory)
        sut.deck = repo.read(identifier: mockedDeckData.identifier)
    }

    func test_manageDeckViewModel_setDeckWith_create_true() {
        sut.deck = nil
        let output = sut.setDeckWith(name: "Teste", description: "Teste teste", keywords: "teste, teste", themeID: 0)

        XCTAssertNotNil(output)
    }

    func test_manageDeckViewModel_setDeckWith_update_true() {
        sut.deck = repo.read(identifier: mockedDeckData.identifier)
        let output = sut.setDeckWith(name: "Mock Edited", description: "Mocked deck", keywords: "mock", themeID: 0)

        XCTAssertNotNil(output)
    }

    func test_menageWordViewModel_deleteDeck_true() {
        let data = DeckData(name: "Mock", description: "Mocked deck", keywords: "mock", themeID: 0)
        repo.create(with: data)
        sut.deck = repo.read(identifier: data.identifier)

        let output = sut.deleteDeck()

        XCTAssertTrue(output)
    }

    override func tearDown() {
        repo.drop()
        repo = nil

        sut = nil

        super.tearDown()
    }
}
