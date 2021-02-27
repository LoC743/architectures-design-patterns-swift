//
//  QuestionViewModelFactory.swift
//  WhoWantsToBeAmillionaire
//
//  Created by Alexey on 26.02.2021.
//

import UIKit

class QuestionViewModelFactory {
    func constructViewModel(from questions: [Question]) -> [QuestionViewModel] {
        return questions.map { getViewModelFromCoreData(from: $0) }
    }
    
    private func getViewModelFromCoreData(from question: Question) -> QuestionViewModel {
        return QuestionViewModel(
            id: Int(question.id),
            text: question.text ?? "",
            correctAnswer: question.correctAnswer ?? "",
            answers: question.answers ?? []
        )
    }
    
    func constructViewModel(from questions: [QuestionModel]) -> [QuestionViewModel] {
        return questions.map { getViewModelFromModel(from: $0) }
    }
    
    private func getViewModelFromModel(from question: QuestionModel) -> QuestionViewModel {
        return QuestionViewModel(id: question.id, text: question.text, correctAnswer: question.correctAnswer, answers: question.answers)
    }
}

