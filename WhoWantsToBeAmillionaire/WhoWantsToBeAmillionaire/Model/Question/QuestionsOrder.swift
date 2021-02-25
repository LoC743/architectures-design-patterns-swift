//
//  QuestionsOrder.swift
//  WhoWantsToBeAmillionaire
//
//  Created by Alexey on 21.02.2021.
//

enum QuestionsOrder: Int {
    case serial
    case random
}

protocol QuestionsOrderStrategy: AnyObject {
    func loadQuestions(completion: @escaping ([Question]) -> Void,
                       failure: @escaping () -> Void)
}

class QuestionsSerialOrderStrategy: QuestionsOrderStrategy {
    func loadQuestions(completion: @escaping ([Question]) -> Void,
                       failure: @escaping () -> Void) {
        QuestionsStorage.shared.get { (questions) in
            completion(questions)
        } failure: {
            failure()
        }
    }
}

class QuestionsRandomOrderStrategy: QuestionsOrderStrategy {
    func loadQuestions(completion: @escaping ([Question]) -> Void,
                       failure: @escaping () -> Void) {
        QuestionsStorage.shared.get { (questions) in
            completion(questions.shuffled())
        } failure: {
            failure()
        }
    }
}

class QuestionsInOrderFacade {
    let mode: QuestionsOrder = Game.shared.questionsMode
    
    private lazy var strategy: QuestionsOrderStrategy = {
        switch mode {
        case .serial:
            return QuestionsSerialOrderStrategy()
        case .random:
            return QuestionsRandomOrderStrategy()
        }
    }()
    
    func get(completion: @escaping ([Question]) -> Void,
             failure: @escaping () -> Void) {
        strategy.loadQuestions { (questions) in
            completion(questions)
        } failure: {
            failure()
        }

    }
}
