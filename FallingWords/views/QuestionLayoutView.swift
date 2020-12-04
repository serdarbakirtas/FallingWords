//
//  QuestionLayoutView.swift
//  FallingWords
//
//  Created by Hasan on 22.11.20.
//
import UIKit

protocol QuestionLayoutViewDelegate: class {
    func timeOut(_ isCorrect: Bool)
    func onCorrectAnswer(_ isCorrect: Bool)
}

class QuestionLayoutView: UIView {
    
    weak var delegate: QuestionLayoutViewDelegate?
    
    // MARK: PROPERTIES
    var animator: UIViewPropertyAnimator? = nil
    let CONSTANT_SPACE: CGFloat = 16
    let ANIMATE_DURATION: Double = 5.0
    
    // MARK: UI
    let quizStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    let labelQuestion: BaseUILabel = {
        let uiLabel = BaseUILabel()
        return uiLabel
    }()
    
    let labelAnswer: BaseUILabel = {
        let uiLabel = BaseUILabel()
        return uiLabel
    }()
    
    let buttonCorrect: BaseUIButton = {
        let uiButton = BaseUIButton()
        uiButton.setTitle("CORRECT", for: .normal)
        return uiButton
    }()
    
    let buttonWrong: BaseUIButton = {
        let uiButton = BaseUIButton()
        uiButton.setTitle("WRONG", for: .normal)
        return uiButton
    }()
    
    let answerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        
        buttonCorrect.addTarget(self, action: #selector(onTapCorrectAnswer), for: .touchUpInside)
        buttonWrong.addTarget(self, action: #selector(onTapWrongAnswer), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            quizStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            quizStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            quizStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: CONSTANT_SPACE),
            quizStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -CONSTANT_SPACE),
        ])
        
        NSLayoutConstraint.activate([
            labelAnswer.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            labelAnswer.centerXAnchor.constraint(equalTo: centerXAnchor),
            labelAnswer.heightAnchor.constraint(equalToConstant: 30),
            labelAnswer.leftAnchor.constraint(equalTo: leftAnchor, constant: CONSTANT_SPACE),
            labelAnswer.rightAnchor.constraint(equalTo: rightAnchor, constant: -CONSTANT_SPACE),
        ])
    }
    
    // MARK: FUNCTIONS
    private func addSubViews() {
        addSubview(quizStackView)
        addSubview(labelAnswer)

        answerStackView.addArrangedSubview(buttonCorrect)
        answerStackView.addArrangedSubview(buttonWrong)
        quizStackView.addArrangedSubview(labelQuestion)
        quizStackView.addArrangedSubview(answerStackView)
    }
    
    func addFallingWordAnimation() {
        labelAnswer.frame.origin.y = -labelAnswer.frame.size.height
        animator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: ANIMATE_DURATION,
                                                                  delay: 1, options: [], animations: {
            self.labelAnswer.frame.origin.y = self.frame.height
        }, completion: { _ in
            self.removeAnimation()
            self.delegate?.timeOut(false)
        })
    }
    
    private func removeAnimation() {
        labelAnswer.layer.removeAllAnimations()
        animator?.stopAnimation(true)
    }
    
    func setQuestionnaire(_ viewModel: GameViewModel) {
        labelQuestion.text = viewModel.engName
        labelAnswer.text = viewModel.spaName
    }
    
    // MARK: ACTIONS
    @objc func onTapCorrectAnswer() {
        removeAnimation()
        delegate?.onCorrectAnswer(true)
    }
    
    @objc func onTapWrongAnswer() {
        removeAnimation()
        delegate?.onCorrectAnswer(false)
    }
}
