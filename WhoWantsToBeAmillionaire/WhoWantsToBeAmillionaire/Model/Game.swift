//
//  Game.swift
//  WhoWantsToBeAmillionaire
//
//  Created by Alexey on 19.02.2021.
//

import Foundation

enum GameResult {
    case win
    case lose
}

class Game {
    static var session: GameSession?
    private(set) static var records: [GameSession] = []
    
    static func end(with state: GameResult) {
           if let session = session {
            records.append(session)
        }
        
        session = nil
    }

    static func clearRecords() {
        records.removeAll()
    }
}

enum Hints {
    case half
    case quiz
    case phoneCall
    case tryToAnswer
}

class GameSession {
    var date: Date = Date()
    var correctAnswers: Int = 0  // Количество правильных ответов
    var questionsCount: Int
    var score: Int = 0           // Количество денег
    var usedHints: [Hints] = []  // Использованные подсказки
    
    init(questionsCount: Int) {
        self.questionsCount = questionsCount
    }
}
