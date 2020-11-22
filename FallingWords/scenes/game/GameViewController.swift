//
//  GameViewController.swift
//  FallingWords
//
//  Created by Hasan on 22.11.20.
//

import UIKit

protocol GameView: BaseView {}

class GameViewController: BaseViewController {

    var presenter: GamePresenter<GameViewController>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Falling Words"
        
        presenter = GamePresenter(view: self)
        presenter.loadWordList()
    }
}

extension GameViewController: GameView {}
