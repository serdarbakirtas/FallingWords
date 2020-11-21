//
//  BasePresenterView.swift
//  FallingWords
//
//  Created by Hasan on 22.11.20.
//

import Foundation

class BaseViewPresenter<T: BaseView>: BasePresenter<T> {
    
    override init(view: T, apiInstance: GameAPI = GameAPIRepo.sharedInstance) {
        super.init(view: view, apiInstance: apiInstance)
    }
}
