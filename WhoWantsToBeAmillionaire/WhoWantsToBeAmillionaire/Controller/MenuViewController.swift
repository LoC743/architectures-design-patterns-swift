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
    var clearResultsButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background
        
        setupIconImageView()
        setupPlayButton()
        setupResultsButton()
        setupClearResultsButton()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
    
    private func setupPlayButton() {
        view.addSubview(playButton)
        
        let width = 150
        let height = 55
        let yOffset = 50
        let iconImageViewFrame = iconImageView.frame
        let frame = CGRect(
            x: Int(view.center.x) - (width/2),
            y: Int(iconImageViewFrame.maxY) + yOffset,
            width: width,
            height: height)
        
        playButton.frame = frame
        playButton.setTitle("Играть", for: .normal)
        playButton.setTitleColor(Colors.text, for: .normal)
        playButton.backgroundColor = Colors.elementBackground
        playButton.layer.cornerRadius = CGFloat(height/2)
        playButton.layer.borderWidth = 1
        playButton.layer.borderColor = Colors.text.cgColor
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
    }
    
    private func setupResultsButton() {
        view.addSubview(resultsButton)
        
        let width = 150
        let height = 55
        let yOffset = 50
        let playButtonFrame = playButton.frame
        let frame = CGRect(
            x: Int(view.center.x) - (width/2),
            y: Int(playButtonFrame.maxY) + yOffset,
            width: width,
            height: height)
        
        resultsButton.frame = frame
        resultsButton.setTitle("Результаты", for: .normal)
        resultsButton.setTitleColor(Colors.text, for: .normal)
        resultsButton.backgroundColor = Colors.elementBackground
        resultsButton.layer.cornerRadius = CGFloat(height/2)
        resultsButton.layer.borderWidth = 1
        resultsButton.layer.borderColor = Colors.text.cgColor
        resultsButton.addTarget(self, action: #selector(resultsButtonTapped), for: .touchUpInside)
    }
    
    private func setupClearResultsButton() {
        view.addSubview(clearResultsButton)
        
        let width = 250
        let height = 55
        let yOffset = 50
        let playButtonFrame = resultsButton.frame
        let frame = CGRect(
            x: Int(view.center.x) - (width/2),
            y: Int(playButtonFrame.maxY) + yOffset,
            width: width,
            height: height)
        
        clearResultsButton.frame = frame
        clearResultsButton.setTitle("Очистить статистику", for: .normal)
        clearResultsButton.setTitleColor(Colors.text, for: .normal)
        clearResultsButton.backgroundColor = Colors.elementBackground
        clearResultsButton.layer.cornerRadius = CGFloat(height/2)
        clearResultsButton.layer.borderWidth = 1
        clearResultsButton.layer.borderColor = Colors.text.cgColor
        clearResultsButton.addTarget(self, action: #selector(clearResultsTapped), for: .touchUpInside)
    }
    
    @objc func playButtonTapped(sender: UIButton!) {
        let questions = QuestionsStorage.shared.getData()
        let gameSession = GameSession(questionsCount: questions.count)
        Game.session = gameSession
        
        let gameVC = GameViewContoller(questions: questions, gameSesson: gameSession)
        gameVC.modalPresentationStyle = .fullScreen
        self.present(gameVC, animated: true, completion: nil)
    }
    
    @objc func resultsButtonTapped(sender: UIButton!) {
        let resultsVC = ResultsTableViewController()
        
        self.present(resultsVC, animated: true, completion: nil)
    }
    
    private func showAlert(title: String, message: String) {
        let alertContoller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertContoller.addAction(action)
        present(alertContoller, animated: true, completion: nil)
    }
    
    @objc func clearResultsTapped(sender: UIButton!) {
        Game.clearResults()
        showAlert(title: "Результаты", message: "Статистика очищена.")
    }
}
