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
    func loadQuestions() -> [Question]
}

class QuestionsSerialOrderStrategy: QuestionsOrderStrategy {
    func loadQuestions() -> [Question] {
        let questions = QuestionsStorage.shared.getData
        
        return questions
    }
}

class QuestionsRandomOrderStrategy: QuestionsOrderStrategy {
    func loadQuestions() -> [Question] {
        var questions = QuestionsStorage.shared.getData
        questions.shuffle()
        
        return questions
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
    
    func get() -> [Question] {
        return strategy.loadQuestions()
    }
}
