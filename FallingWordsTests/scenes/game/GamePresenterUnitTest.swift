//
//  GamePresenterUnitTest.swift
//  FallingWordsTests
//
//  Created by Hasan on 22.11.20.
//

@testable import FallingWords
import XCTest
import MockUIAlertController

class GamePresenterUnitTest: XCTestCase {
    
    var alertVerifier: QCOMockAlertVerifier!
    var presenter: GamePresenter<GameViewMock>!
    let viewMock = GameViewMock()
    let apiMock = GameAPIMock()
    
    var wordList = WordList(eng: "english", spa: "spanish")
    var gameData = GameData(question: "english", answer: "inglesa", isTranslation: true)
    var answer = Answers(isCorrect: true)
    
    override func setUp() {
        super.setUp()
        
        alertVerifier = QCOMockAlertVerifier()
        presenter = GamePresenter(view: viewMock, apiInstance: apiMock)
    }
    
    override func tearDown() {
        super.tearDown()
        
        alertVerifier = nil
    }
    
    func testLoadingWordsAddsWords() {
        presenter.loadWordList()
        wait(for: [viewMock.reloadGameViewExpectation], timeout: 1)
        
        XCTAssertEqual(presenter.items.count, 1)
    }
    
    func testGettingGameViewModel() {
        presenter.result.append(gameData)
        
        let viewModel = presenter.getWordViewModel(count: 0)
        
        XCTAssertEqual(viewModel.engName, wordList.eng)
    }
    
    func testSendingAnswerSendsTrue() {
        presenter.result.append(gameData)
        presenter.onSendAnswer(isAnswer: true)
        
        XCTAssertEqual(apiMock.correctAnswer?.isCorrect, answer.isCorrect)
        XCTAssertTrue((apiMock.correctAnswer != nil))
        XCTAssertEqual(viewMock.isCorrectAnswer, true)
    }
    
    func testSendingAnswerSendsFalse() {
        answer.isCorrect = false
        
        presenter.result.append(gameData)
        presenter.onSendAnswer(isAnswer: false)
        
        XCTAssertEqual(apiMock.correctAnswer?.isCorrect, answer.isCorrect)
        XCTAssertEqual(viewMock.isCorrectAnswer, false)
    }
    
    func testGettingGameResult() {
        let isFinish = presenter.isFinishGame()
        
        XCTAssertEqual(apiMock.isFinishGameCalled, isFinish)
    }
    
    func testGettingNextQuestionCount() {
        presenter.result.append(gameData)
        
        _ = presenter.getWordViewModel(count: 0)
        let count = presenter.getNextQuestionCount()
        
        XCTAssertEqual(count, 1)
    }
    
    func testGettingGameRestuls() {
        _ = presenter.isFinishGame()
        
        apiMock.getResults { answer in
            XCTAssertEqual(answer.count, 3)
        }
    }
    
    func testAddingQuestionsGetsGameRestuls() {
        presenter.currentQuestionNumber = 14
        _ = presenter.isFinishGame()
        
        XCTAssertEqual(apiMock.isRemoveAnswerCalled, true)
        XCTAssertFalse((apiMock.correctAnswer != nil))
    }
    
    func testAddingWrongAnswersGetsGameRestuls() {
        presenter.totalWrongCount = 3
        apiMock.correctAnswer?.isCorrect = false
        _ = presenter.isFinishGame()
        
        XCTAssertEqual(apiMock.isRemoveAnswerCalled, true)
    }
    
    func testTappingYesRemovesAllDataAndCreatesNewGame() {
        presenter.totalWrongCount = 3
        apiMock.correctAnswer?.isCorrect = false
        _ = presenter.isFinishGame()
        
        alertVerifier.executeActionForButton(withTitle: "yes")
        
        XCTAssertEqual(apiMock.isRemoveAnswerCalled, true)
        XCTAssertFalse((apiMock.correctAnswer != nil))
    }
    
    func testTappingNoRemovesAllData() {
        presenter.totalWrongCount = 3
        apiMock.correctAnswer?.isCorrect = false
        _ = presenter.isFinishGame()
        
        alertVerifier.executeActionForButton(withTitle: "no")
        wait(for: [viewMock.showThanksViewExpectation], timeout: 1)
        
        XCTAssertEqual(viewMock.isThanksViewCalled, true)
        XCTAssertFalse((apiMock.correctAnswer != nil))
    }
}

