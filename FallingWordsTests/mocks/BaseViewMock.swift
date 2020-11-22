//
//  BaseViewMock.swift
//  FallingWordsTests
//
//  Created by Hasan on 22.11.20.
//

@testable import FallingWords
import XCTest

class BaseViewMock: NSObject, BaseView {
    
    var isShowAlertCalled = false
    var isHideIndicatorCalled = false
    
    var showAlertExp = XCTestCase().expectation(description: "Show Alert")
    var hideActivityIndicatorExp = XCTestCase().expectation(description: "Hide Indicator")
    
    func showAlert(title: String?, message: String?, actions: [UIAlertAction]?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions ?? [] {
            alert.addAction(action)
        }
        UIApplication.shared.windows.first { $0.isKeyWindow }?.rootViewController?.present(alert, animated: false,
                                                                                           completion: nil)
        isShowAlertCalled = true
        showAlertExp.fulfill()
    }
    
    func showFullScreenActivityIndicator(isShown: Bool) {
        if !isShown, !isHideIndicatorCalled {
            isHideIndicatorCalled = true
            hideActivityIndicatorExp.fulfill()
        }
    }
}
