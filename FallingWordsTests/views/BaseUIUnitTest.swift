//
//  BaseUIUnitTest.swift
//  FallingWordsTests
//
//  Created by Hasan on 22.11.20.
//

@testable import FallingWords
import XCTest

class BaseUIUnitTest: XCTestCase {
    
    var buttonCorrectTapExpectation = XCTestCase().expectation(description: "Button Tap Correct")
    var buttonWrongTapExpectation = XCTestCase().expectation(description: "Button Tap Wrong")
    
    var isButtonCorrectCalled = false
    var isButtonWrongCalled = false
    
    let layoutView = QuestionLayoutView()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAddingButtonChecksCoder() {
        let archiver = NSKeyedArchiver(requiringSecureCoding: true)
        let uiButton = BaseUIButton(coder: archiver)
        
        XCTAssertNil(uiButton)
    }
    
    func testAddingLabelChecksCoder() {
        let archiver = NSKeyedArchiver(requiringSecureCoding: true)
        let uiLabel = BaseUILabel(coder: archiver)
        
        XCTAssertNil(uiLabel)
    }
    
    func testAddingQuestionLayoutChecksCoder() {
        let archiver = NSKeyedArchiver(requiringSecureCoding: true)
        let uiView = QuestionLayoutView(coder: archiver)
        
        XCTAssertNil(uiView)
    }
    
    func testAddingAnimator() {
        let uiView = QuestionLayoutView()
        uiView.addFallingWordAnimation()
        
        XCTAssertNotNil(uiView.animator)
    }
    
    func testTapppingCorrectAnswerSendsData() {
        layoutView.buttonCorrect.addTarget(self, action: #selector(onTapCorrectAnswer), for: .touchUpInside)
        layoutView.buttonCorrect.sendActions(for: .touchUpInside)

        wait(for: [buttonCorrectTapExpectation], timeout: 0.1)
        
        XCTAssertEqual(isButtonCorrectCalled, true)
    }
    
    func testTapppingWrongAnswerSendsData() {
        layoutView.buttonWrong.addTarget(self, action: #selector(onTapWrongAnswer), for: .touchUpInside)
        layoutView.buttonWrong.sendActions(for: .touchUpInside)

        wait(for: [buttonWrongTapExpectation], timeout: 0.1)
        
        XCTAssertEqual(isButtonWrongCalled, true)
    }

    @objc func onTapCorrectAnswer() {
        buttonCorrectTapExpectation.fulfill()
        isButtonCorrectCalled = true
    }
    
    @objc func onTapWrongAnswer() {
        buttonWrongTapExpectation.fulfill()
        isButtonWrongCalled = true
    }
    
    func testGettingErrorMessage() {
        let apiError = APIError(message: "message", code: .NOT_FOUND)
        let apiError404 = APIError(message: "message", code: 404)
        let apiErrorNone = APIError(message: "message", code: 300)
        
        XCTAssertEqual(apiError.message, "message")
        XCTAssertEqual(apiError404.code, StatusCode(rawValue: 404))
        XCTAssertEqual(apiErrorNone.code, .NONE)
    }
}


