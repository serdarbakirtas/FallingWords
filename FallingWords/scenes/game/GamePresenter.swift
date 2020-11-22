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
    var totalCorrectCount: Int = 0
    
    let TOTAL_QUESTIONS_COUNT = 15
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
        var random = NumberGenerator(random: { UInt64(self.TOTAL_QUESTIONS_COUNT) })
        let wordsShuffled = items.shuffled(using: &random).shuffled()
        let prefix = Array(wordsShuffled.prefix(TOTAL_QUESTIONS_COUNT))
        let suffix = Array(wordsShuffled.suffix(TOTAL_QUESTIONS_COUNT))
        
        for (index, _) in wordsShuffled.enumerated() {
            if result.count < TOTAL_QUESTIONS_COUNT {
                if isCorrectQuestion {
                    result.append(GameData(question: prefix[index].eng, answer: prefix[index].spa,
                                           isTranslation: isCorrectQuestion))
                } else {
                    result.append(GameData(question: prefix[index].eng, answer: suffix[index].spa,
                                           isTranslation: suffix[index].spa == prefix[index].spa))
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
    
    func onSendAnswer(isAnswer: Bool) {
        if isAnswer == result[currentQuestionNumber].isTranslation {
            apiInstance.sendAnswer(answer: Answers(isCorrect: true))
            view?.isCorrectAnswer(true)
        } else {
            apiInstance.sendAnswer(answer: Answers(isCorrect: false))
            view?.isCorrectAnswer(false)
        }
    }
    
    func isFinishGame() -> Bool {
        apiInstance.getResults {[unowned self] (answers) in
            totalWrongCount = answers.filter { $0.isCorrect == false } .map { $0.isCorrect }.count
            totalCorrectCount = answers.filter { $0.isCorrect == true } .map { $0.isCorrect }.count
            if totalWrongCount >= MAX_TOTAL_WRONG_ANSWER {
                let totalCorrect = answers.filter { $0.isCorrect == true } .map { $0.isCorrect }
                askUserGameEndScenerio(totalScore: totalCorrect.count, message: "😰 You did 3 wrongs")
            } else {
                if currentQuestionNumber >= TOTAL_QUESTIONS_COUNT - 1 {
                    askUserGameEndScenerio(totalScore: totalCorrectCount, message: "Congrats 🎉 Your score")
                }
            }
        }
        return currentQuestionNumber == TOTAL_QUESTIONS_COUNT - 1 || totalWrongCount == MAX_TOTAL_WRONG_ANSWER
    }
    
    func getNextQuestionCount() -> Int {
        currentQuestionNumber += 1
        return currentQuestionNumber
    }
    
    private func askUserGameEndScenerio(totalScore: Int, message: String) {
        removeDatas()
        var actions = [UIAlertAction]()
        actions.append(UIAlertAction(title: "yes", style: .default, handler: { _ in
            self.removeDatas()
            self.createNewGameWithRandomWords()
            self.resetGameData()
        }))
        actions.append(UIAlertAction(title: "no", style: .destructive, handler: { _ in
            self.removeDatas()
            self.view?.showThanksView()
        }))
        view?.showAlert(title: message + " \(TOTAL_QUESTIONS_COUNT) / \(totalScore)", message: "Play again?", actions: actions)
    }
    
    private func removeDatas() {
        apiInstance.removeAnswerData()
        result.removeAll()
    }
    
    private func resetGameData() {
        currentQuestionNumber = 0
        totalWrongCount = 0
        isCorrectQuestion = true
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
