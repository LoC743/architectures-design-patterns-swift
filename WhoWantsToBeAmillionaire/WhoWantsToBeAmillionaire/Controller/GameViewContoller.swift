//
//  GameViewContoller.swift
//  WhoWantsToBeAmillionaire
//
//  Created by Alexey on 19.02.2021.
//

import UIKit

class GameViewContoller: UIViewController {
    // Hints
    var halfHintButton = UIButton()
    var quizHintButton = UIButton()
    var phoneCallHintButton = UIButton()
    var tryHintButton = UIButton()
    // Current State info
    var scoreLabel = UILabel()
    // Question and ansers
    var questionLabel = UILabel()
    var answerA = UIButton()
    var answerB = UIButton()
    var answerC = UIButton()
    var answerD = UIButton()
    
    weak var gameSessionDelegate: GameSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 13/255, green: 0, blue: 75/255, alpha: 1.0)
        
        setupScoreLabel()
        setupQuestionLabel()
        setupAnswerButtons()
        setupHints()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func setupScoreLabel() {
        view.addSubview(scoreLabel)
        
        let window = UIApplication.shared.windows[0]
        let topPadding = window.safeAreaInsets.top
        let width = view.bounds.width
        let y = topPadding + 15
        let height = 40
        let frame = CGRect(
            x: 0,
            y: Int(y),
            width: Int(width),
            height: height
        )
        
        scoreLabel.frame = frame
        scoreLabel.textAlignment = .center
        scoreLabel.textColor = .black
        scoreLabel.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        scoreLabel.text = "Вопрос №1. Сумма: 500 ₽"
    }
    
    private func setupQuestionLabel() {
        view.addSubview(questionLabel)
        
        let scoreLabelFrame = scoreLabel.frame
        let scoreOffset = 25
        let offset = 15
        let height = 100
        let frame = CGRect(
            x: offset,
            y: Int(scoreLabelFrame.maxY) + scoreOffset,
            width: Int(view.bounds.width) - offset*2,
            height: height
        )
        
        questionLabel.frame = frame
        questionLabel.numberOfLines = 0
        questionLabel.textColor = .white
        questionLabel.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0.1764705882, alpha: 1)
        questionLabel.layer.cornerRadius = CGFloat(height)/4
        questionLabel.layer.masksToBounds = true
        questionLabel.text = "Test question"
        questionLabel.textAlignment = .center
    }
    
    private func setupAnswerButtons() {
        view.addSubview(answerA)
        view.addSubview(answerB)
        view.addSubview(answerC)
        view.addSubview(answerD)
        
        let sideOffset = 15
        let bottomOffset = 20
        let height = 50
        
        answerA.frame = CGRect(
            x: sideOffset,
            y: Int(questionLabel.frame.maxY) + bottomOffset,
            width: Int(view.bounds.width) - sideOffset*2,
            height: height
        )
        
        answerB.frame = CGRect(
            x: sideOffset,
            y: Int(answerA.frame.maxY) + bottomOffset,
            width: Int(view.bounds.width) - sideOffset*2,
            height: height
        )
        
        answerC.frame = CGRect(
            x: sideOffset,
            y: Int(answerB.frame.maxY) + bottomOffset,
            width: Int(view.bounds.width) - sideOffset*2,
            height: height
        )
        
        answerD.frame = CGRect(
            x: sideOffset,
            y: Int(answerC.frame.maxY) + bottomOffset,
            width: Int(view.bounds.width) - sideOffset*2,
            height: height
        )
        
        [answerA, answerB, answerC, answerD].forEach { (button) in
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0.1764705882, alpha: 1)
            button.layer.cornerRadius = CGFloat(height/2)
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    private func setupHints() {
        view.addSubview(halfHintButton)
        view.addSubview(quizHintButton)
        view.addSubview(phoneCallHintButton)
        view.addSubview(tryHintButton)
        
        let window = UIApplication.shared.windows[0]
        let bottomPadding = window.safeAreaInsets.bottom
        let width = 50
        let height = width
        let offset = (Int(view.bounds.width) - width*4)/5
        let y = Int(view.frame.height - bottomPadding) - width/2 - 50
        
        halfHintButton.frame = CGRect(
            x: offset,
            y: y,
            width: width,
            height: height
        )
        
        quizHintButton.frame = CGRect(
            x: Int(halfHintButton.frame.maxX) + offset,
            y: y,
            width: width,
            height: height
        )
        
        phoneCallHintButton.frame = CGRect(
            x: Int(quizHintButton.frame.maxX) + offset,
            y: y,
            width: width,
            height: height
        )
        
        tryHintButton.frame = CGRect(
            x: Int(phoneCallHintButton.frame.maxX) + offset,
            y: y,
            width: width,
            height: height
        )
        
        [halfHintButton, quizHintButton, phoneCallHintButton, tryHintButton].forEach { (button) in
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0.1764705882, alpha: 1)
            button.layer.cornerRadius = CGFloat(height/2)
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.white.cgColor
        }
    }
}
