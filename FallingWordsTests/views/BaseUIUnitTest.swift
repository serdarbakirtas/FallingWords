//
//  BaseUIUnitTest.swift
//  FallingWordsTests
//
//  Created by Hasan on 22.11.20.
//

@testable import FallingWords
import XCTest

class BaseUIUnitTest: XCTestCase {
    
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
        let uiLabel = QuestionLayoutView(coder: archiver)
        XCTAssertNil(uiLabel)
    }
}
