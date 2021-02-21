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

enum Notifications: String {
    case currentQuestion = "CurrentQuestionChanged"
}

class GameSession {
    // MARK: - TODO: Добавить затраченное время
    var date: Date = Date()
    var correctAnswers: Int = 0    // Количество правильных ответов
    var questionsCount: Int        // Количество вопросов
    var currentQuestion: Int = 0 { // Номер текущего вопроса
        didSet {
            NotificationCenter.default.post(name: Notification.Name(Notifications.currentQuestion.rawValue), object: nil)
        }
    }
    var score: Int = 0             // Количество денег
    var usedHints: [Hints] = []    // Использованные подсказки
    
    init(questionsCount: Int) {
        self.questionsCount = questionsCount
    }
}
