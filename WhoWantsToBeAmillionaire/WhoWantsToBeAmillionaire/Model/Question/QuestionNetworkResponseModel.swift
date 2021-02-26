//
//  QuestionNetworkResponseModel.swift
//  WhoWantsToBeAmillionaire
//
//  Created by Alexey on 26.02.2021.
//

import Foundation

struct QuestionNetworkResponseModel {
    let id: Int
    let text: String
    let correctAnswer: String
    let answers: [String]
}
