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
    
    var money: Int = 20000 // start from: 20 000
    let moneyMultiplier: Double = 2.0
    var secondLife: Bool = false
    var questions: [Question] = []
    weak var gameSessionDelegate: GameSession?
    private let hintManager: HintManager = HintManager()
    
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
        // Подписка на уведомления
        let notificationName = Notification.Name(Notifications.currentQuestion.rawValue)
        NotificationCenter.default.addObserver(self, selector: #selector(currentQuestionValueChanged), name: notificationName, object: nil)
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
        let width = Int(view.bounds.width) - sideOffset*2

        let answerButtons = [answerA, answerB, answerC, answerD]
        for (index, button) in answerButtons.enumerated() {
            var yOffset = Int(questionLabel.frame.maxY) + bottomOffset
            if index != 0 {
                yOffset = Int(answerButtons[index - 1].frame.maxY) + bottomOffset
            }
            
            button.frame = CGRect(
                x: sideOffset,
                y: yOffset,
                width: width,
                height: height
            )
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
        
        let hintButtons = [halfHintButton, quizHintButton, phoneCallHintButton, tryHintButton]
        for (index, button) in hintButtons.enumerated() {
            var xOffset = offset
            if index != 0 {
                xOffset += Int(hintButtons[index - 1].frame.maxX)
            }
            
            button.frame = CGRect(
                x: xOffset,
                y: y,
                width: width,
                height: height
            )
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
        guard let question = getCurrentQuestion() else { return }
        
        let answersToRemove = hintManager.fiftyFifty(question: question)
        [answerA, answerB, answerC, answerD].forEach { (button) in
            if let titleLabel = button.titleLabel,
               let text = titleLabel.text,
               answersToRemove.contains(text) {
                button.setTitle("", for: .normal)
                button.isUserInteractionEnabled = false
                button.isEnabled = false
            }
        }
        
        halfHintButton.isUserInteractionEnabled = false
        halfHintButton.isEnabled = false
    }
    
    @objc func quizHintButtonTapped(sender: UIButton!) {
        guard let question = getCurrentQuestion() else { return }
        
        let randAnswerIndex = hintManager.hallHelp(question: question)
        showAlert(title: "Подсказка зала", message: "Большинство проголосовало за \(randAnswerIndex+1) ответ.")
        
        quizHintButton.isUserInteractionEnabled = false
        quizHintButton.isEnabled = false
    }
    
    @objc func phoneCallHintButtonTapped(sender: UIButton!) {
        guard let question = getCurrentQuestion() else { return }
        
        let friendGuessIndex = hintManager.callFriend(question: question)
        showAlert(title: "Звонок другу", message: "Ваш друг считает что правильный ответ № \(friendGuessIndex+1).")
        
        phoneCallHintButton.isUserInteractionEnabled = false
        phoneCallHintButton.isEnabled = false
    }
    
    @objc func tryHintButtonTapped(sender: UIButton!) {
        secondLife = hintManager.secondTry()
        
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
        guard let session = Game.shared.session else { return }
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
            case .friendCall:
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
            
            gameSessionDelegate?.currentQuestion += 1
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
        showAlert(title: "Победа!", message: "Поздравляем, Вы ответили правильно на все вопросы.", actionHandler: backToMenu(_:))
        Game.shared.end(with: .win)
    }
    
    private func lose() {
        showAlert(title: "Поражение!", message: "К сожалению вы правильно ответили только на \(gameSessionDelegate?.correctAnswers ?? 0) вопросов из \(gameSessionDelegate?.questionsCount ?? 0). Попробуйте еще раз?", actionHandler: backToMenu(_:))
        Game.shared.end(with: .lose)

    }
    
    private func correctAnswer() {
        // Сохранить результаты в сессию
        gameSessionDelegate?.correctAnswers += 1
        gameSessionDelegate?.score = money
        // Обновить данные экран
        increaseMoney()
        fillGameData()
        enableButtons()
    }
    
    private func increaseMoney() {
        let moneyDouble: Double = Double(money) * moneyMultiplier
        money = Int(moneyDouble)
    }
    
    private func getCurrentQuestion() -> Question? {
        guard let gameSession = gameSessionDelegate else { return nil }
        let currentQuestionIndex = gameSession.correctAnswers
        if currentQuestionIndex < questions.count {
            return questions[currentQuestionIndex]
        }
        
        return nil
    }
    
    // MARK: - Action - нажатие на кнопку с ответом
    
    @objc func answerTapped(sender: UIButton!) {
        guard let gameSession = gameSessionDelegate else { return }
        let currentQuestionIndex = gameSession.correctAnswers
        
        if currentQuestionIndex < questions.count &&
            sender.titleLabel?.text == questions[currentQuestionIndex].correctAnswer {
            sender.backgroundColor = .green
            disableButtons()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                guard let self = self else { return }
                self.correctAnswer()
            }
        } else if secondLife {
            sender.backgroundColor = .red
            sender.isEnabled = false
            sender.isUserInteractionEnabled = false
        } else {
            sender.backgroundColor = .red
            disableButtons()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                guard let self = self else { return }
                self.lose()
            }
        }
        secondLife = false
    }
    
    // MARK: - Action Handler для Alert
    
    private func backToMenu(_: UIAlertAction) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - (Selector) наблюдает за изменением текущего вопроса
    @objc func currentQuestionValueChanged() {
        guard let delegate = gameSessionDelegate else { return }
        let percent = Double(delegate.correctAnswers)/Double(delegate.questionsCount) * 100
        scoreLabel.text = "Вопрос №\(delegate.currentQuestion) (\(Int(percent))%). Сумма: \(money) ₽"
    }
    
    // MARK: - Деструктор
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
