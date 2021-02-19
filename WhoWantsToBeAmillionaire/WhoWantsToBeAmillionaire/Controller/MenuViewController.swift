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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 13/255, green: 0, blue: 75/255, alpha: 1.0)
        
        setupIconImageView()
        setupPlayButton()
        setupResultsButton()
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
        playButton.setTitleColor(.white, for: .normal)
        playButton.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0.1764705882, alpha: 1)
        playButton.layer.cornerRadius = CGFloat(height/2)
        playButton.layer.borderWidth = 1
        playButton.layer.borderColor = UIColor.white.cgColor
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
        resultsButton.setTitleColor(.white, for: .normal)
        resultsButton.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0.1764705882, alpha: 1)
        resultsButton.layer.cornerRadius = CGFloat(height/2)
        resultsButton.layer.borderWidth = 1
        resultsButton.layer.borderColor = UIColor.white.cgColor
        resultsButton.addTarget(self, action: #selector(resultsButtonTapped), for: .touchUpInside)
    }
    
    @objc func playButtonTapped(sender: UIButton!) {
        let questions = QuestionsStorage.shared.getData()
        let gameSession = GameSession(questionsCount: questions.count)
        Game.shared = gameSession
        
        let gameVC = GameViewContoller(questions: questions, gameSesson: gameSession)
        gameVC.modalPresentationStyle = .fullScreen
        self.present(gameVC, animated: true, completion: nil)
    }
    
    @objc func resultsButtonTapped(sender: UIButton!) {
      print("Button tapped")
    }
}
