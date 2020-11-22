//
//  BaseViewPresenterUnitTest.swift
//  FallingWordsTests
//
//  Created by Hasan on 22.11.20.
//

@testable import FallingWords
import XCTest

class BaseViewPresenterUnitTest: XCTestCase {
    
    var presenter: BasePresenter<BaseViewMock>!
    let viewMock = BaseViewMock()
    let apiMock = GameAPIMock()
    
    override func setUp() {
        super.setUp()
        
        presenter = BasePresenter(view: viewMock, apiInstance: apiMock)
    }
    
    override func tearDown() {
        super.tearDown()
    }
}
