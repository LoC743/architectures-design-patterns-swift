//
//  ResultsCaretaker.swift
//  WhoWantsToBeAmillionaire
//
//  Created by Alexey on 19.02.2021.
//

import Foundation

class ResultsCaretaker {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let key = "WhoWantsToBeAmillionaireResults"
    
    func saveResults(results: [GameResult]) {
        do {
            let data: Memento = try encoder.encode(results)
            UserDefaults.standard.setValue(data, forKey: key)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadResults() -> [GameResult] {
        guard let data: Memento = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        
        do {
            return try decoder.decode([GameResult].self, from: data)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}

