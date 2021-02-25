//
//  Result.swift
//  WhoWantsToBeAmillionaire
//
//  Created by Alexey on 19.02.2021.
//

import Foundation

struct GameResult {
    var date: Date
    var correctAnswersCount: Int
    var usedHintsCount: Int
    var score: Int
}

extension GameResult: Codable {}

typealias Memento = Data
