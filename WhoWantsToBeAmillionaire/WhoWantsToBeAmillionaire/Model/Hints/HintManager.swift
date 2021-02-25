//
//  HintManager.swift
//  WhoWantsToBeAmillionaire
//
//  Created by Alexey on 25.02.2021.
//

import Foundation

class HintManager {
    func fiftyFifty(question: Question) -> [String] {
        Game.shared.session?.usedHints.append(.half)
        var withoutCorrentAnswers: [String] = {
            var answers = question.answers
            answers.remove(at: question.correctAnswerIndex ?? 0)
            return answers
        }()
        
        withoutCorrentAnswers.shuffle()
        withoutCorrentAnswers.removeLast()
        
        return withoutCorrentAnswers
    }
}