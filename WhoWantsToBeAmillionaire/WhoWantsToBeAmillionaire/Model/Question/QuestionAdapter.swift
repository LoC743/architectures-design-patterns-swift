//
//  QuestionAdapter.swift
//  WhoWantsToBeAmillionaire
//
//  Created by Alexey on 25.02.2021.
//

import Foundation

protocol QuestionAdapterProtocol: AnyObject {
    func loadQuestions(completion: @escaping ([Question]) -> Void,
                       failure: @escaping () -> Void)
    
    func saveQuestions(questions: [Question])
}

class QuestionAdapter: QuestionAdapterProtocol {
    private let questionCaretaker = QuestionCaretaker()
    
    func loadQuestions(completion: @escaping ([Question]) -> Void,
                       failure: @escaping () -> Void) {
        NetworkManager.shared.loadQuestionList { [weak self] (questionList) in
            guard let self = self,
                  let questionList = questionList else { return }
            self.questionCaretaker.saveQuestions(questions: questionList.questions)
            completion(questionList.questions)
        } failure: { [weak self] in
            guard let self = self else { return }
            let dbQuestions = self.questionCaretaker.loadQuestions()
            
            if dbQuestions.isEmpty {
                failure()
            } else {
                completion(dbQuestions)
            }
        }
    }
    
    func saveQuestions(questions: [Question]) {
        questionCaretaker.saveQuestions(questions: questions)
    }
       
}
