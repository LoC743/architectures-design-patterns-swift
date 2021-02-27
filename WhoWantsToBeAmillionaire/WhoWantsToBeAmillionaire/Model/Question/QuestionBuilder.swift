//
//  QuestionBuilder.swift
//  WhoWantsToBeAmillionaire
//
//  Created by Alexey on 23.02.2021.
//

import Foundation

class QuestionBuilder {
    private var question: String?
    
    private var answerA: String?
    private var answerB: String?
    private var answerC: String?
    private var answerD: String?
    
    private var correctAnswer: String?
    private var correctAnswerIndex: Int?
    
    func set(question: String) {
        self.question = question
    }
    
    func set(answerA: String) {
        self.answerA = answerA
    }
    
    func set(answerB: String) {
        self.answerB = answerB
    }
    
    func set(answerC: String) {
        self.answerC = answerC
    }
    
    func set(answerD: String) {
        self.answerD = answerD
    }
    
    func set(correctAnswer: String) {
        self.correctAnswer = correctAnswer
    }
    
    func set(correctAnswerIndex: Int) {
        self.correctAnswerIndex = correctAnswerIndex
    }
    
    func build() -> QuestionViewModel {
        let id = QuestionsStorage.shared.getLastIndex() ?? 1
        let questionText: String = question ?? ""
        let answers: [String] = [answerA ?? "", answerB ?? "", answerC ?? "", answerD ?? ""]
        
        var correct: String = ""
        if let correctAnswer = correctAnswer {
            correct = correctAnswer
        } else if let correctAnswerIndex = correctAnswerIndex,
                  correctAnswerIndex > -1 && correctAnswerIndex < answers.count {
            correct = answers[correctAnswerIndex]
        }
        
        return QuestionViewModel(id: id, text: questionText, correctAnswer: correct, answers: answers)
    }
}
