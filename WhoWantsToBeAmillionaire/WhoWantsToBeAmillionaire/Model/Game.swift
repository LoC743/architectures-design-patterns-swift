//
//  Game.swift
//  WhoWantsToBeAmillionaire
//
//  Created by Alexey on 19.02.2021.
//

import Foundation

enum GameResultState {
    case win
    case lose
}

class Game {
    static var session: GameSession?
    private static let resultsCaretaker = ResultsCaretaker()
    
    private(set) static var results: [GameResult] = {
       return resultsCaretaker.loadResults()
    }() {
        didSet {
            resultsCaretaker.saveResults(results: results)
        }
    }
    
    static func end(with state: GameResultState) {
        if let session = Game.session {
            let gameResult = GameResult(date: session.date, correctAnswersCount: session.correctAnswers, usedHintsCount: session.usedHints.count, score: session.score)
            results.append(gameResult)
        }
        
        Game.session = nil
    }
    
    static func clearResults() {
        results = []
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
