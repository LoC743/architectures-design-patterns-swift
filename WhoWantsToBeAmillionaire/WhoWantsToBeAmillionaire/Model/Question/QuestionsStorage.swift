//
//  QuestionsStorage.swift
//  WhoWantsToBeAmillionaire
//
//  Created by Alexey on 22.02.2021.
//

import Foundation

class QuestionsStorage {
    static var shared = QuestionsStorage()
        
    private let questionAdapter = QuestionAdapter()
    private lazy var questions: [Question] = [] {
        didSet {
            questionAdapter.saveQuestions(questions: questions)
        }
    }
    
    private init() { }
    
    private func tryToLoad(completion: @escaping ([Question]) -> Void,
                           failure: @escaping () -> Void) {
        questionAdapter.loadQuestions { [weak self] (loadedQuestions) in
            guard let self = self else { return }
            self.questions = loadedQuestions
            completion(loadedQuestions)
        } failure: {
            failure()
        }
    }
    
    func add(question: Question) {
        questions.append(question)
    }
    
    func remove(at: Int) {
        questions.remove(at: at)
    }
    
    func get(completion: @escaping ([Question]) -> Void,
             failure: @escaping () -> Void) {
        if isEmpty() {
            tryToLoad { (loadedQuestions) in
                completion(loadedQuestions)
            } failure: {
               failure()
            }
        } else {
            completion(questions)
        }
    }
    
    func size() -> Int {
        return questions.count
    }
    
    func isEmpty() -> Bool {
        return questions.isEmpty
    }
    
    func getLastIndex() -> Int? {
        return questions.last?.id
    }
}
