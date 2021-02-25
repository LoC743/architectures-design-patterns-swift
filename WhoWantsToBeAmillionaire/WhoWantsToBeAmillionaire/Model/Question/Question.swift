//
//  Question.swift
//  WhoWantsToBeAmillionaire
//
//  Created by Alexey on 19.02.2021.
//

struct Question {
    let id: Int
    let text: String
    let correctAnswer: String
    var correctAnswerIndex: Int? {
        return answers.firstIndex(of: correctAnswer)
    }
    let answers: [String]
}

extension Question: Codable {}
