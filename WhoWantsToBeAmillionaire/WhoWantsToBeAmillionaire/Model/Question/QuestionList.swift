//
//  QuestionList.swift
//  WhoWantsToBeAmillionaire
//
//  Created by Alexey on 25.02.2021.
//

import Foundation

class QuestionList: Decodable {
    var questions: [Question] = []
    
    enum QuestionCodingKeys: String, CodingKey {
        case id
        case correctAnswer
        case answers
        case text
    }
    
    required init(from decoder: Decoder) throws {
        var items = try decoder.unkeyedContainer()
        let itemsCount: Int = items.count ?? 0
        
        for _ in 0..<itemsCount {
            let questionContainer = try items.nestedContainer(keyedBy: QuestionCodingKeys.self)
            
            let id = try questionContainer.decode(Int.self, forKey: .id)
            let correctAnswer = try questionContainer.decode(String.self, forKey: .correctAnswer)
            let answers = try questionContainer.decode(Array<String>.self, forKey: .answers)
            let text = try questionContainer.decode(String.self, forKey: .text)
            
            let question = Question(id: id, text: text, correctAnswer: correctAnswer, answers: answers)
            self.questions.append(question)
        }
    }
}
