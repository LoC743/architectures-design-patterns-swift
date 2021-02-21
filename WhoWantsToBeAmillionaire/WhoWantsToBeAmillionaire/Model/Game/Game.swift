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
    static var shared = Game()
    
    var session: GameSession?
    var questionsMode: QuestionsOrder {
        didSet {
            questionsModeCaretaker.saveMode(mode: questionsMode)
        }
    }
    
    private let resultsCaretaker = ResultsCaretaker()
    private let questionsModeCaretaker = QuestionModeCaretaker()
    
    private init() {
        questionsMode = questionsModeCaretaker.loadMode()
    }
    
    private(set) lazy var results: [GameResult] = {
       return resultsCaretaker.loadResults()
    }() {
        didSet {
            resultsCaretaker.saveResults(results: results)
        }
    }
    
    func end(with state: GameResultState) {
        if let session = Game.shared.session {
            let gameResult = GameResult(date: session.date, correctAnswersCount: session.correctAnswers, usedHintsCount: session.usedHints.count, score: session.score)
            results.append(gameResult)
        }
        
        Game.shared.session = nil
    }
    
    func clearResults() {
        results = []
    }
}
