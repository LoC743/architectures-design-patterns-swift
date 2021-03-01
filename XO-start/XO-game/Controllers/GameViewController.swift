//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    private let gameBoard = Gameboard()
    private var currentState: GameState! {
        didSet {
            currentState.begin()
        }
    }
    
    private lazy var referee = Referee(gameboard: gameBoard)
    
    private var counter = 0
    
    var gameMode: GameMode?
    
    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    @IBOutlet var menuButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButtons()
        
        setFirstState()
        
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }

            self.currentState.addMark(at: position)
            if self.currentState.isMoveCompleted {
                
                self.counter += 1
                
                self.setNextState()
            }
        }
    }
    
    private func setupButtons() {
        ([restartButton, menuButton] as! [UIButton]).forEach { (button) in
            button.layer.masksToBounds = true
            button.layer.cornerRadius = button.frame.height/4
        }
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        
        Log(action: .restartGame)
        
        gameboardView.clear()
        gameBoard.clear()
        setFirstState()
    }
    
    private func setFirstState() {
        guard let gameMode = gameMode else { return }
        
        counter = 0
        let player = Player.first
        currentState = PlayerState(player: player, gameViewController: self,
                                   gameBoard: gameBoard, gameBoardView: gameboardView,
                                   markViewPrototype: player.markViewPrototype, gameMode: gameMode)
    }
    
    private func setNextState() {
        guard let gameMode = gameMode else { return }
        
        if let winner = referee.determineWinner() {
            currentState = GameOverState(winner: winner, gameViewController: self, gameMode: gameMode)
            return
        }
        
        if counter >= 9 {
            currentState = GameOverState(winner: nil, gameViewController: self, gameMode: gameMode)
            return
        }
        
        
        if let playerInputState = currentState as? PlayerState {
            let player = playerInputState.player.next
            
            currentState = PlayerState(player: player, gameViewController: self,
                                       gameBoard: gameBoard, gameBoardView: gameboardView,
                                       markViewPrototype: player.markViewPrototype, gameMode: gameMode)
            
            if gameMode == .vsAI && player == .second {
                let position = gameboardView.generatePosition()
                gameboardView.onSelectPosition?(position)
            }
            
            
        }
    }
    
    // MARK: - (Action): Back to Menu
    
    @IBAction func backToMenuTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
