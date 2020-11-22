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
    var result: [GameData] = []
    var isCorrectQuestion: Bool = true
    var currentQuestionNumber = 0
    var totalWrongCount = 0
    
    let NUMBER_OF_QUESTIONS = 15
    let MAX_TOTAL_WRONG_ANSWER = 3
    
    override init(view: T, apiInstance: GameAPI = GameAPIRepo.sharedInstance) {
        super.init(view: view, apiInstance: apiInstance)
    }
    
    // MARK: FUNCTIONS
    private func onWordListLoaded(wordList: [WordList]) {
        items = wordList
        createNewGameWithRandomWords()
    }
    
    private func createNewGameWithRandomWords() {
        var random = NumberGenerator(random: { UInt64(self.NUMBER_OF_QUESTIONS) })
        let allWordsShuffled = items.shuffled(using: &random).shuffled()
        let shuffledPrefix = Array(allWordsShuffled.prefix(NUMBER_OF_QUESTIONS))
        let shuffledSuffix = Array(allWordsShuffled.suffix(NUMBER_OF_QUESTIONS))
        
        for (index, _) in allWordsShuffled.enumerated() {
            if result.count < NUMBER_OF_QUESTIONS {
                if isCorrectQuestion {
                    result.append(GameData(question: shuffledPrefix[index].eng, answer: shuffledPrefix[index].spa,
                                           isTranslation: isCorrectQuestion))
                } else {
                    result.append(GameData(question: shuffledPrefix[index].eng, answer: shuffledSuffix[index].spa,
                                           isTranslation: shuffledSuffix[index].spa == shuffledPrefix[index].spa))
                }
                isCorrectQuestion = !isCorrectQuestion
            }
        }
        result = result.shuffled()
        view?.reloadGame(result)
    }
    
    func getWordViewModel(count: Int) -> GameViewModel {
        let gameWord = result[count]
        return GameViewModel(from: gameWord)
    }
    
    // MARK: API CALLS
    func loadWordList() {
        apiInstance.getWordList()
            .applySchedulers()
            .showFullScreenActivityIndicator(view: view)
            .subscribe(onSuccess: {[unowned self] words in
                        self.onWordListLoaded(wordList: words)},
                       onError: {[unowned self] error in
                        self.interpretError(title: "Loading Error", error: error)})
            .disposed(by: disposeBag)
    }
}
