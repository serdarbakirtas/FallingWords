//
//  GamePresenter.swift
//  FallingWords
//
//  Created by Hasan on 22.11.20.
//

import RxSwift

class GamePresenter<T: GameView>: BasePresenter<T> {
    
    // MARK: PROPERTIES
    let disposeBag = DisposeBag()
    var items: [WordList] = []
    
    override init(view: T, apiInstance: GameAPI = GameAPIRepo.sharedInstance) {
        super.init(view: view, apiInstance: apiInstance)
    }
    
    // MARK: FUNCTIONS
    private func removeAllWordList() {
        items.removeAll()
    }
    
    private func onWordListLoaded(wordList: [WordList]) {
        addWordList(items: wordList)
    }
    
    private func addWordList(items: [WordList]) {
        for item in items {
            if !self.items.contains(where: { $0.eng == item.eng }) { // Filter the same questios
                self.items.append(item)
            }
        }
        print(items)
    }
    
    // MARK: API CALLS
    func loadWordList() {
        apiInstance.getWordList()
            .applySchedulers()
            .showFullScreenActivityIndicator(view: view)
            .doOnSuccess(removeAllWordList)
            .subscribe(onSuccess: {[unowned self] words in
                        self.onWordListLoaded(wordList: words)},
                       onError: {[unowned self] error in
                        self.interpretError(title: "exampleLoadingError", error: error)})
            .disposed(by: disposeBag)
    }
}
