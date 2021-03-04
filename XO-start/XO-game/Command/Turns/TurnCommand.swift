//
//  TurnCommand.swift
//  XO-game
//
//  Created by Alexey on 02.03.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

class TurnCommand {
    let action: TurnAction
    
    init(action: TurnAction) {
        self.action = action
    }
    
    var placeMark: GameboardPosition {
        switch action {
        case let .firstPlayerTurn(position: position):
            return position
        case let .secondPlayerTurn(position: position):
            return position
        }
    }
}
