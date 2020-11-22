//
//  GameViewController.swift
//  FallingWords
//
//  Created by Hasan on 22.11.20.
//

import UIKit

protocol GameView: BaseView {
    func reloadGame(_ items: [GameData])
}

class GameViewController: BaseViewController {

    var presenter: GamePresenter<GameViewController>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Falling Words"
        
        presenter = GamePresenter(view: self)
        presenter.loadWordList()
    }
    
    // MARK: FUNCTIONS
    private func getViewModelToCreateQuestion(index: Int) {
        let wordViewModel = presenter.getWordViewModel(count: index)
        print(wordViewModel.engName)
    }
}

extension GameViewController: GameView {
    
    func reloadGame(_ items: [GameData]) {
        getViewModelToCreateQuestion(index: 0)
    }
}
