//
//  GameViewMock.swift
//  FallingWordsTests
//
//  Created by Hasan on 22.11.20.
//

@testable import FallingWords
import XCTest

class GameViewMock: BaseViewMock, GameView {
    
    var reloadGameViewExpectation = XCTestCase().expectation(description: "Reload Game View")
    var showThanksViewExpectation = XCTestCase().expectation(description: "Show Thanks View")
    
    var isCorrectAnswer = false
    var isThanksViewCalled = false
    
    func reloadGame(_ items: [GameData]) {
        reloadGameViewExpectation.fulfill()
    }
    
    func showThanksView() {
        showThanksViewExpectation.fulfill()
        isThanksViewCalled = true
    }
    
    func isCorrectAnswer(_ isCorrect: Bool) {
        isCorrectAnswer = isCorrect
    }
}
