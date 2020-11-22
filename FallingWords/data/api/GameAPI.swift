//
//  GameAPI.swift
//  FallingWords
//
//  Created by Hasan on 22.11.20.
//

import Alamofire
import RxSwift

protocol GameAPI {
    
    // MARK: GET
    func getWordList() -> Single<[WordList]>
    func getResults(completion: @escaping ([Answers]) -> Void)
    
    // MARK: POST
    func sendAnswer(answer: Answers) // Can send the API or keep it in the local repository
    
    // MARK: REMOVE
    func removeAnswerData() // Can send the API or keep it in the local repository
}
