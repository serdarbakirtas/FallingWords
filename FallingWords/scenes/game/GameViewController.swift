//
//  GameViewController.swift
//  FallingWords
//
//  Created by Hasan on 22.11.20.
//

import UIKit

protocol GameView: BaseView {
    func reloadGame(_ items: [GameData])
    func showThanksView()
    func isCorrectAnswer(_ isCorrect: Bool)
}

class GameViewController: BaseViewController {

    // MARK: UI
    let questionLayoutView: QuestionLayoutView = {
        let layoutView = QuestionLayoutView()
        layoutView.translatesAutoresizingMaskIntoConstraints = false
        layoutView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return layoutView
    }()
    
    let labelThanks: BaseUILabel = {
        let uiLabel = BaseUILabel()
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        uiLabel.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        uiLabel.text = "Thank you!"
        return uiLabel
    }()
    
    // MARK: PROPERTIES
    var barButtonItem: UIBarButtonItem?
    
    var presenter: GamePresenter<GameViewController>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Falling Words"
        
        barButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        barButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Verdana", size: 10.0)!], for: .normal)
        navigationItem.setRightBarButton(barButtonItem, animated: false)
        
        presenter = GamePresenter(view: self)
        presenter.loadWordList()
        
        addSubviews()
    }
    
    // MARK: FUNCTIONS
    private func getViewModelToCreateQuestion(index: Int) {
        let wordViewModel = presenter.getWordViewModel(count: index)
        questionLayoutView.labelQuestion.text = wordViewModel.engName
        questionLayoutView.labelAnswer.text = wordViewModel.spaName
        questionLayoutView.addFallingWordAnimation()
    }
    
    private func addSubviews() {
        view.addSubview(questionLayoutView)
        questionLayoutView.delegate = self
        
        NSLayoutConstraint.activate([
            questionLayoutView.leftAnchor.constraint(equalTo: view.leftAnchor),
            questionLayoutView.rightAnchor.constraint(equalTo: view.rightAnchor),
            questionLayoutView.topAnchor.constraint(equalTo: view.topAnchor),
            questionLayoutView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1),
        ])
    }
}

extension GameViewController: GameView {
    
    func reloadGame(_ items: [GameData]) {
        getViewModelToCreateQuestion(index: 0)
        barButtonItem?.title = ""
    }
    
    func showThanksView() {
        questionLayoutView.removeFromSuperview()
        view.addSubview(labelThanks)
        
        NSLayoutConstraint.activate([
            labelThanks.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelThanks.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    func isCorrectAnswer(_ isCorrect: Bool) {
        barButtonItem?.title = isCorrect == true ? "✔️" : "❌"
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
            barButtonItem?.title = "✔️ \(presenter.totalCorrectCount) - ❌ \(presenter.totalWrongCount)"
        }
    }
}

extension GameViewController: QuestionLayoutViewDelegate {
    
    func timeOut(_ isCorrect: Bool) {
        isCorrectAnswer(false)
        presenter.apiInstance.sendAnswer(answer: Answers(isCorrect: false))
        if !presenter.isFinishGame() {
            getViewModelToCreateQuestion(index: self.presenter.getNextQuestionCount())
        }
    }
    
    func onCorrectAnswer(_ isCorrect: Bool) {
        presenter.onSendAnswer(isAnswer: isCorrect)
        if !presenter.isFinishGame() {
            getViewModelToCreateQuestion(index: self.presenter.getNextQuestionCount())
        }
    }
}
