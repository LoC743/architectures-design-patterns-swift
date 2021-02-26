//
//  QuestionViewModel.swift
//  WhoWantsToBeAmillionaire
//
//  Created by Alexey on 19.02.2021.
//

protocol QuestionModel {
    var id: Int { get }
    var text: String { get }
    var correctAnswer: String { get }
    var answers: [String] { get }
}

struct QuestionViewModel: QuestionModel {
    let id: Int
    let text: String
    let correctAnswer: String
    var correctAnswerIndex: Int? {
        return answers.firstIndex(of: correctAnswer)
    }
    let answers: [String]
}
