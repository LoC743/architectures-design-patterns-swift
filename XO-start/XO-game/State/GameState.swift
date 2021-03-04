//
//  GameState.swift
//  XO-game
//
//  Created by Evgenii Semenov on 27.02.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

enum GameMode: Int {
    case vsPerson
    case vsAI
}

protocol GameState {

    var isMoveCompleted: Bool { get }
    
    var gameMode: GameMode { get }
    
    func begin()
    func addMark(at position: GameboardPosition)
}
