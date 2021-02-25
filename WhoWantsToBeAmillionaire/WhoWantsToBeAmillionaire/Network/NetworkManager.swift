//
//  NetworkManager.swift
//  WhoWantsToBeAmillionaire
//
//  Created by Alexey on 25.02.2021.
//

import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() { }
    
    enum Paths: String {
        case questions = "https://raw.githubusercontent.com/LoC743/architectures-design-patterns-swift/lesson-3/basic-patterns-3/data/questions.json"
    }
    
    @discardableResult
    func loadQuestionList(completion: @escaping (QuestionList?) -> Void, failure: @escaping () -> Void) -> Request? {

        let url = Paths.questions.rawValue

        return Session.custom.request(url).responseData { response in
            guard let data = response.value,
                  let questionList = try? JSONDecoder().decode(QuestionList.self, from: data)
            else {
                print("Failed to pase questions JSON!")
                failure()
                return
            }

            completion(questionList)
        }
    }
}
