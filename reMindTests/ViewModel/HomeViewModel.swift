//
//  HomeViewModel.swift
//  reMindTests
//
//  Created by Pedro Sousa on 10/02/21.
//

import XCTest
@testable import reMind

class HomeViewModelTest: XCTestCase {

    var sut: HomeViewModel!
    var repo: DeckRepository!

    override func setUp() {
        super.setUp()
        repo = DeckRepository.inMemory

        repo.create(with: DeckData(name: "Teste 1", description: "Description 1", keywords: "keyword1, keyword2"))
        repo.create(with: DeckData(name: "Teste 2", description: "Description 2", keywords: "keyword3, keyword4"))
        repo.create(with: DeckData(name: "Teste 3", description: "Description 3", keywords: "keyword1, keyword3"))

        sut = HomeViewModel(.inMemory)
    }

    func test_homeViewModel_numberOfItems_3() {
        let actual = sut.numberOfItems()

        XCTAssertEqual(actual, 3)
    }

    func test_homeViewModel_getName_true() {
        let expected = "Teste 1"
        
        let actual = sut.getName(for: 0)

        XCTAssertEqual(expected, actual)
    }

    override func tearDown() {
        repo.drop()
        repo = nil
        sut = nil
        super.tearDown()
    }

}
