//
//  GameSession.swift
//  WhoWantsToBeAmillionaire
//
//  Created by Alexey on 21.02.2021.
//

import Foundation

enum Hints {
    case half
    case quiz
    case phoneCall
    case tryToAnswer
}

class GameSession {
    // MARK: - TODO: Добавить затраченное время
    var date: Date = Date()
    var correctAnswers: Int = 0  // Количество правильных ответов
    var questionsCount: Int      // Количество вопросов
    var currentQuestion: Int = 1 // Номер текущего вопроса
    var score: Int = 0           // Количество денег
    var usedHints: [Hints] = []  // Использованные подсказки
    
    init(questionsCount: Int) {
        self.questionsCount = questionsCount
    }
}
