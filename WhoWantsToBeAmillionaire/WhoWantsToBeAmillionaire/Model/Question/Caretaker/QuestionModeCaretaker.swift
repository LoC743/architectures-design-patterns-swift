//
//  QuestionModeCaretaker.swift
//  WhoWantsToBeAmillionaire
//
//  Created by Alexey on 21.02.2021.
//

import Foundation

class QuestionModeCaretaker {
    private let defaults = UserDefaults.standard
    private let key = "WhoWantsToBeAmillionaireQuestionsMode"
    
    func saveMode(mode: QuestionsOrder) {
        defaults.setValue(mode.rawValue, forKey: key)
    }
    
    func loadMode() -> QuestionsOrder {
        let modeIndex = defaults.integer(forKey: key)
        let mode = QuestionsOrder(rawValue: modeIndex) ?? .serial
        
        return mode
    }
}


