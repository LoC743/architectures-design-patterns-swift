//
//  NetworkManagerProxy.swift
//  WhoWantsToBeAmillionaire
//
//  Created by Alexey on 08.03.2021.
//

import Foundation

protocol NetworkManagerInterface {
    func loadQuestionList(completion: @escaping (QuestionList?) -> Void, failure: @escaping () -> Void)
}

class NetworkManagerProxy: NetworkManagerInterface {
    let networkManager: NetworkManagerInterface
    
    init(networkManager: NetworkManagerInterface) {
        self.networkManager = networkManager
    }
    
    func loadQuestionList(completion: @escaping (QuestionList?) -> Void, failure: @escaping () -> Void) {
        print("[\(#function)]: Starting...")
        networkManager.loadQuestionList { (questionList) in
            print("[\(#function)]: Questions list loaded successfully.")
            completion(questionList)
        } failure: {
            print("[\(#function)]: Error with loading questions list.")
            failure()
        }
    }
}
