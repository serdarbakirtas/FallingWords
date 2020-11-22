//
//  GameAPIMock.swift
//  FallingWordsTests
//
//  Created by Hasan on 22.11.20.
//

@testable import FallingWords
import RxSwift
import XCTest

class GameAPIMock: GameAPI {
    
    var correctAnswer: Answers
    var isFinishGameCalled = true
    var isRemoveAnswerCalled = false
    
    init() {
        correctAnswer = Answers(isCorrect: true)
    }
    
    // MARK: HELPER METHODS
    private func createGameObject() -> WordList {
        let wordList = WordList(eng: "", spa: "")
        return wordList
    }
    
    func getWordList() -> Single<[WordList]> {
        let wordList = createGameObject()
        return Single.just([wordList])
    }
    
    func getResults(completion: @escaping ([Answers]) -> Void) {
        isFinishGameCalled = false
        
        completion([correctAnswer, correctAnswer, correctAnswer])
    }
    
    func sendAnswer(answer: Answers) {
        correctAnswer = answer
    }
    
    func removeAnswerData() {
        isRemoveAnswerCalled = true
    }
}
