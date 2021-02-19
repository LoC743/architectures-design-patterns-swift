//
//  Game.swift
//  WhoWantsToBeAmillionaire
//
//  Created by Alexey on 19.02.2021.
//

class Game {
    static var shared: GameSession?
}

enum Hints {
    case half
    case quiz
    case phoneCall
    case tryToAnswer
}

class GameSession {
    var correctAnswers: Int = 0 // Количество правильных ответов
    var questionsCount: Int
    var score: Int = 0 // Количество денег
    var usedHints: [Hints] = []// Использованные подсказки
    
    init(questionsCount: Int) {
        self.questionsCount = questionsCount
    }
}
