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
    
    var money: Int = 50000 // start from: 50 000
    var secondLife: Bool = false
    var questions: [Question] = []
    weak var gameSessionDelegate: GameSession?
    
    init(questions: [Question], gameSesson: GameSession) {
        super.init(nibName: nil, bundle: nil)
        self.questions = questions
        self.gameSessionDelegate = gameSesson
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background
        
        setupScoreLabel()
        setupQuestionLabel()
        setupAnswerButtons()
        setupHints()
        
        fillGameData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Настройка UI элементов
    
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
        scoreLabel.textColor = Colors.textAlternative
        scoreLabel.backgroundColor = Colors.scoreBackground
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
        questionLabel.textColor = Colors.text
        questionLabel.backgroundColor = Colors.elementBackground
        questionLabel.layer.cornerRadius = CGFloat(height)/4
        questionLabel.layer.masksToBounds = true
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
            button.setTitleColor(Colors.text, for: .normal)
            button.backgroundColor = Colors.elementBackground
            button.layer.cornerRadius = CGFloat(height/2)
            button.layer.borderWidth = 1
            button.layer.borderColor = Colors.text.cgColor
            button.addTarget(self, action: #selector(answerTapped), for: .touchUpInside)
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
            button.setTitleColor(Colors.text, for: .normal)
            button.tintColor = Colors.text
            button.layer.cornerRadius = CGFloat(height/2)
            button.backgroundColor = Colors.elementBackground
        }
        
        halfHintButton.setImage(UIImage(named: "half"), for: .normal)
        halfHintButton.addTarget(self, action: #selector(halfHintButtonTapped), for: .touchUpInside)
        
        quizHintButton.setImage(UIImage(systemName: "person.3"), for: .normal)
        quizHintButton.addTarget(self, action: #selector(quizHintButtonTapped), for: .touchUpInside)
        
        phoneCallHintButton.setImage(UIImage(named: "phone"), for: .normal)
        phoneCallHintButton.addTarget(self, action: #selector(phoneCallHintButtonTapped), for: .touchUpInside)
        
        tryHintButton.setImage(UIImage(named: "secondTry"), for: .normal)
        tryHintButton.addTarget(self, action: #selector(tryHintButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions, Обработка нажатий на кнопки подсказок
    
    @objc func halfHintButtonTapped(sender: UIButton!) {
        guard let gameSession = gameSessionDelegate else { return }
        let currentQuestionIndex = gameSession.correctAnswers
        if currentQuestionIndex < questions.count {
            let question = questions[currentQuestionIndex]
            
            var buttonsDisabled: Int = 0
            var lastRand: Int = -1
            let answers = [answerA, answerB, answerC, answerD]
            while buttonsDisabled != 2 {
                let randIndex = Int.random(in: 0..<question.answers.count)
                if question.answers[randIndex] != question.correctAnswer &&
                    randIndex != lastRand &&
                    answers[randIndex].backgroundColor != .red
                    {
                    answers[randIndex].setTitle("", for: .normal)
                    answers[randIndex].isUserInteractionEnabled = false
                    answers[randIndex].isEnabled = false
                    lastRand = randIndex
                    buttonsDisabled += 1
                }
            }
        }
        
        Game.session?.usedHints.append(.half)
        
        halfHintButton.isUserInteractionEnabled = false
        halfHintButton.isEnabled = false
    }
    
    @objc func quizHintButtonTapped(sender: UIButton!) {
        guard let gameSession = gameSessionDelegate else { return }
        let currentQuestionIndex = gameSession.correctAnswers
        if currentQuestionIndex < questions.count {
            let question = questions[currentQuestionIndex]
            
            let randIndex = Int.random(in: 0..<question.answers.count)
            showAlert(title: "Подсказка зала", message: "Большинство проголосовало за \(randIndex+1) ответ.")
            
            Game.session?.usedHints.append(.quiz)
            
            quizHintButton.isUserInteractionEnabled = false
            quizHintButton.isEnabled = false
        }
    }
    
    @objc func phoneCallHintButtonTapped(sender: UIButton!) {
        guard let gameSession = gameSessionDelegate else { return }
        let currentQuestionIndex = gameSession.correctAnswers
        if currentQuestionIndex < questions.count {
            let question = questions[currentQuestionIndex]
            
            var answer = 1
            let isFriendSmart = Bool.random()
            if isFriendSmart,
               let correctAnswerIndex = question.correctAnswerIndex {
                answer = correctAnswerIndex + 1
            } else {
                let randIndex = Int.random(in: 0..<question.answers.count)
                answer = randIndex + 1
            }
            showAlert(title: "Звонок другу", message: "Ваш друг считает что правильный ответ № \(answer).")
            
            Game.session?.usedHints.append(.phoneCall)
            
            phoneCallHintButton.isUserInteractionEnabled = false
            phoneCallHintButton.isEnabled = false
        }
    }
    
    @objc func tryHintButtonTapped(sender: UIButton!) {
        secondLife = true
        
        Game.session?.usedHints.append(.tryToAnswer)
        
        tryHintButton.isUserInteractionEnabled = false
        tryHintButton.isEnabled = false
    }
    
    // MARK: - Включение/выключение кнопок
    
    private func disableButtons() {
        [answerA, answerB, answerC, answerD, halfHintButton, quizHintButton, phoneCallHintButton, tryHintButton].forEach { (button) in
            button.isEnabled = false
            button.isUserInteractionEnabled = false
        }
    }
    
    private func enableButtons() {
        guard let session = Game.session else { return }
        [answerA, answerB, answerC, answerD, halfHintButton, quizHintButton, phoneCallHintButton, tryHintButton].forEach { (button) in
            button.isEnabled = true
            button.isUserInteractionEnabled = true
        }
        
        for hintButton in session.usedHints {
            switch hintButton {
            case .half:
                halfHintButton.isEnabled = false
                halfHintButton.isUserInteractionEnabled = false
            case .quiz:
                quizHintButton.isEnabled = false
                quizHintButton.isUserInteractionEnabled = false
            case .phoneCall:
                phoneCallHintButton.isEnabled = false
                phoneCallHintButton.isUserInteractionEnabled = false
            case .tryToAnswer:
                tryHintButton.isEnabled = false
                tryHintButton.isUserInteractionEnabled = false
            }
        }
    }
    
    // MARK: - Основная логика
    
    private func fillGameData() {
        guard let gameSession = gameSessionDelegate else { return }
        let currentQuestionIndex = gameSession.correctAnswers
        if currentQuestionIndex < questions.count {
            let question = questions[currentQuestionIndex]
            
            scoreLabel.text = "Вопрос №\(currentQuestionIndex+1). Сумма: \(money) ₽"
            questionLabel.text = question.text
            for (i, button) in [answerA, answerB, answerC, answerD].enumerated() {
                button.setTitle(question.answers[i], for: .normal)
                button.backgroundColor = Colors.elementBackground
            }
        } else {
            win()
        }
    }
    
    private func win() {
        showEndGameAlert(title: "Победа!", message: "Поздравляем, Вы ответили правильно на все вопросы.")
        Game.end(with: .win)
    }
    
    private func lose() {
        showEndGameAlert(title: "Поражение!", message: "К сожалению вы правильно ответили только на \(gameSessionDelegate?.correctAnswers ?? 0) вопросов из \(gameSessionDelegate?.questionsCount ?? 0). Попробуйте еще раз?")
        Game.end(with: .lose)

    }
    
    private func correctAnswer() {
        gameSessionDelegate?.correctAnswers += 1
        gameSessionDelegate?.score = money
        money *= 2
        fillGameData()
        enableButtons()
    }
    
    // MARK: - Action - нажатие на кнопку с ответом
    
    @objc func answerTapped(sender: UIButton!) {
        guard let gameSession = gameSessionDelegate else { return }
        let currentQuestionIndex = gameSession.correctAnswers
        
        if currentQuestionIndex < questions.count &&
            sender.titleLabel?.text == questions[currentQuestionIndex].correctAnswer {
            sender.backgroundColor = .green
            disableButtons()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.correctAnswer()
            }
        } else if secondLife {
            sender.backgroundColor = .red
            sender.isEnabled = false
            sender.isUserInteractionEnabled = false
        } else {
            sender.backgroundColor = .red
            disableButtons()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.lose()
            }
        }
        secondLife = false
    }
    
    // MARK: - Отображение Alert
    private func showAlert(title: String, message: String) {
        let alertContoller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertContoller.addAction(action)
        present(alertContoller, animated: true, completion: nil)
    }
    
    private func showEndGameAlert(title: String, message: String) {
        let alertContoller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: backToMenu(_:))
        alertContoller.addAction(action)
        present(alertContoller, animated: true, completion: nil)
    }
    
    private func backToMenu(_: UIAlertAction) {
        self.dismiss(animated: true, completion: nil)
    }
}
