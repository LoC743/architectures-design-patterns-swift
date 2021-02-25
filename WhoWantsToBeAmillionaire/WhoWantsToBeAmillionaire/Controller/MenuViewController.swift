//
//  MenuViewController.swift
//  WhoWantsToBeAmillionaire
//
//  Created by Alexey on 19.02.2021.
//

import UIKit

class MenuViewController: UIViewController {
    var iconImageView = UIImageView()
    var playButton = UIButton()
    var resultsButton = UIButton()
    var settingsButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background
        
        setupElements()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Настройка UI элементов
    private func setupElements() {
        setupIconImageView()
        
        let offset = Int((UIScreen.main.bounds.height - iconImageView.frame.maxY - 150) / 4)
        let buttonHeight = 50
        setupPlayButton(offset, buttonHeight)
        setupResultsButton(offset, buttonHeight)
        setupSettingsButton(offset, buttonHeight)
        setupButtonsStyle(buttonHeight)
    }
    
    private func setupIconImageView() {
        view.addSubview(iconImageView)
        
        let originY = 100
        let width = 280
        let frame = CGRect(
            x: Int(view.center.x) - (width/2),
            y: originY,
            width: width,
            height: width
        )
        
        iconImageView.frame = frame
        iconImageView.image = UIImage(named: "icon")
    }
    
    private func setupPlayButton(_ offset: Int, _ height: Int) {
        view.addSubview(playButton)
        
        let width = 150
        let yOffset = offset
        let iconImageViewFrame = iconImageView.frame
        let frame = CGRect(
            x: Int(view.center.x) - (width/2),
            y: Int(iconImageViewFrame.maxY) + yOffset,
            width: width,
            height: height)
        
        playButton.frame = frame
        playButton.setTitle("Играть", for: .normal)
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
    }
    
    private func setupResultsButton(_ offset: Int, _ height: Int) {
        view.addSubview(resultsButton)
        
        let width = 150
        let yOffset = offset
        let playButtonFrame = playButton.frame
        let frame = CGRect(
            x: Int(view.center.x) - (width/2),
            y: Int(playButtonFrame.maxY) + yOffset,
            width: width,
            height: height)
        
        resultsButton.frame = frame
        resultsButton.setTitle("Результаты", for: .normal)
        resultsButton.addTarget(self, action: #selector(resultsButtonTapped), for: .touchUpInside)
    }
    
    private func setupSettingsButton(_ offset: Int, _ height: Int) {
        view.addSubview(settingsButton)
        
        let width = 150
        let yOffset = offset
        let playButtonFrame = resultsButton.frame
        let frame = CGRect(
            x: Int(view.center.x) - (width/2),
            y: Int(playButtonFrame.maxY) + yOffset,
            width: width,
            height: height)
        
        settingsButton.frame = frame
        settingsButton.setTitle("Настройки", for: .normal)
        settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
    }
    
    private func setupButtonsStyle(_ buttonHeight: Int) {
        [playButton, resultsButton, settingsButton].forEach { (button) in
            button.setTitleColor(Colors.text, for: .normal)
            button.backgroundColor = Colors.elementBackground
            button.layer.cornerRadius = CGFloat(buttonHeight/2)
            button.layer.borderWidth = 1
            button.layer.borderColor = Colors.text.cgColor
        }
    }
    
    // MARK: - Action-ы кнопок

    @objc func playButtonTapped(sender: UIButton!) {
        let questions = QuestionsInOrderFacade().get()
        let gameSession = GameSession(questionsCount: questions.count)
        Game.shared.session = gameSession
        
        let gameVC = GameViewContoller(questions: questions, gameSesson: gameSession)
        gameVC.modalPresentationStyle = .fullScreen
        self.present(gameVC, animated: true, completion: nil)
    }
    
    // MARK: - Переход в таблицу Результаты
    
    @objc func resultsButtonTapped(sender: UIButton!) {
        let resultsVC = ResultsTableViewController()
        
        self.present(resultsVC, animated: true, completion: nil)
    }
    
    // MARK: - Переход в Настройки
    
    @objc func settingsButtonTapped(sender: UIButton!) {
        let settingsVC = SettingsViewController()
        
        self.present(settingsVC, animated: true, completion: nil)
    }
}
