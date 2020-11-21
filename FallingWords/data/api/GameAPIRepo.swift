//
//  GameAPIRepo.swift
//  FallingWords
//
//  Created by Hasan on 22.11.20.
//

import Alamofire
import RxSwift

class GameAPIRepo: GameAPI {
    
    // SINGLETON
    static let sharedInstance = GameAPIRepo()
    
    private init() {}
    
    static let BASE_URL = "https://gist.githubusercontent.com/DroidCoder/"
    
    private func getAuthenticatedHeader() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        return headers
    }
    
    private func createSingleRequest<T: Decodable>(url: String, method: HTTPMethod, parameters: Parameters? = nil,
                                                   headers: HTTPHeaders? = nil) -> Single<T> {
        let reqHeaders = headers ?? getAuthenticatedHeader()
        let encoding: ParameterEncoding = (method == .post || method == .put || method == .patch)
            ? JSONEncoding.default : URLEncoding.default
        return Single.create { single in
            let request = AF.request(url, method: method, parameters: parameters,
                                     encoding: encoding, headers: reqHeaders)
                .validate()
                .responseJSON { responseJSON in
                    guard let data = responseJSON.data else { return }
                    do {
                        let decoder = JSONDecoder()
                        let wordListRequest = try decoder.decode(T.self, from: data)
                        single(.success(wordListRequest))
                    } catch let error {
                        single(.error(error.asAFError!.getAsAPIError(responseData: responseJSON.data)))
                    }
                }
            return Disposables.create { request.cancel() }
        }
    }
    
    // MARK: GET
    func getWordList() -> Single<[WordList]> {
        let url = "7ac6cdb4bf5e032f4c737aaafe659b33/raw/baa9fe0d586082d85db71f346e2b039c580c5804/words.json"
        return createSingleRequest(url: GameAPIRepo.BASE_URL + url, method: .get)
    }
}
