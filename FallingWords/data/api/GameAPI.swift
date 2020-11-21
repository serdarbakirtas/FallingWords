//
//  GameAPI.swift
//  FallingWords
//
//  Created by Hasan on 22.11.20.
//

import RxSwift

protocol GameAPI {
    
    // MARK: GET
    func getWordList() -> Single<[WordList]>
}
