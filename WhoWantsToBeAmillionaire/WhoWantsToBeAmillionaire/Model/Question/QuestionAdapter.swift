//
//  QuestionAdapter.swift
//  WhoWantsToBeAmillionaire
//
//  Created by Alexey on 25.02.2021.
//

import Foundation

protocol QuestionAdapterProtocol: AnyObject {
    func loadQuestions(completion: @escaping ([QuestionModel]) -> Void,
                       failure: @escaping () -> Void)
    
    func saveQuestions(questions: [QuestionModel])
    
    func saveQuestion(question: QuestionModel)
    
    func removeQuestion(question: QuestionModel)
}

class QuestionAdapter: QuestionAdapterProtocol {
    private let questionCaretaker = QuestionCaretaker()
    private let viewModelFactory = QuestionViewModelFactory()
    
    func loadQuestions(completion: @escaping ([QuestionModel]) -> Void,
                       failure: @escaping () -> Void) {
        // Try to get data from database
        let dbQuestions = self.questionCaretaker.loadQuestions()
        
        // If there is no data try to load from server
        if dbQuestions.isEmpty {
            NetworkManager.shared.loadQuestionList { [weak self] (questionList) in
                guard let self = self,
                      let questionList = questionList else { return }
                self.questionCaretaker.saveQuestions(questions: questionList.questions)
                completion(questionList.questions)
            } failure: {
                failure()
            }
        } else {
            // If there is data in database
            completion(self.viewModelFactory.constructViewModel(from: dbQuestions))
        }
    }
    
    func saveQuestions(questions: [QuestionModel]) {
        questionCaretaker.saveQuestions(questions: questions)
    }
    
    func saveQuestion(question: QuestionModel) {
        questionCaretaker.saveQuestion(question: question)
    }
    
    func removeQuestion(question: QuestionModel) {
        questionCaretaker.removeQuestion(question: question)
    }
       
}
