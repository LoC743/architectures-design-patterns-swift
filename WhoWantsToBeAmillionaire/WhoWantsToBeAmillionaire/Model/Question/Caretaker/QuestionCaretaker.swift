//
//  QuestionCaretaker.swift
//  WhoWantsToBeAmillionaire
//
//  Created by Alexey on 22.02.2021.
//

import Foundation
import UIKit
import CoreData

class QuestionCaretaker {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveQuestion(question: QuestionModel) {
        let newQuestion = Question(context: context)
        newQuestion.id = Int64(question.id)
        newQuestion.correctAnswer = question.correctAnswer
        newQuestion.text = question.text
        newQuestion.answers = question.answers
        
        saveContext()
    }
    
    func saveQuestions(questions: [QuestionModel]) {
        questions.forEach { (question) in
            saveQuestion(question: question)
        }
    }
    
    func removeQuestion(question: QuestionModel) {
        for dbQuestion in loadQuestions() {
            if question.id == dbQuestion.id {
                context.delete(dbQuestion)
                break
            }
        }
        
        saveContext()
    }
    
    func loadQuestions() -> [Question] {
        var items: [Question] = []
        do {
            items = try context.fetch(Question.fetchRequest())
        } catch {
            print(error.localizedDescription)
        }
        
        return items
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
