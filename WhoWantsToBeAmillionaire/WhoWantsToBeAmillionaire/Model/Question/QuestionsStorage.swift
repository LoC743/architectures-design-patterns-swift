//
//  QuestionsStorage.swift
//  WhoWantsToBeAmillionaire
//
//  Created by Alexey on 22.02.2021.
//

import Foundation

class QuestionsStorage {
    static var shared = QuestionsStorage()
        
    private let questionAdapter: QuestionAdapterProtocol = QuestionAdapter()
    private lazy var questions: [QuestionModel] = []
    
    private init() { }
    
    private func tryToLoad(completion: @escaping ([QuestionModel]) -> Void,
                           failure: @escaping () -> Void) {
        questionAdapter.loadQuestions { [weak self] (loadedQuestions) in
            guard let self = self else { return }
            self.questions = loadedQuestions
            completion(loadedQuestions)
        } failure: {
            failure()
        }
    }
    
    func add(question: QuestionModel) {
        questions.append(question)
        questionAdapter.saveQuestion(question: question)
    }
    
    func remove(at: Int) {
        let question = questions[at]
        questionAdapter.removeQuestion(question: question)
        questions.remove(at: at)
    }
    
    func get(completion: @escaping ([QuestionModel]) -> Void,
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
        return Int(questions.last?.id ?? 0)
    }
}
