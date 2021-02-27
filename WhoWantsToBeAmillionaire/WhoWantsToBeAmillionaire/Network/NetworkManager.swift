//
//  NetworkManager.swift
//  WhoWantsToBeAmillionaire
//
//  Created by Alexey on 25.02.2021.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() { }
    
    enum Paths: String {
        case questions = "https://raw.githubusercontent.com/LoC743/architectures-design-patterns-swift/lesson-3/basic-patterns-3/data/questions.json"
    }
    
    func loadQuestionList(completion: @escaping (QuestionList?) -> Void, failure: @escaping () -> Void) {
        guard let url = URL(string: Paths.questions.rawValue) else { return }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                  let questionList = try? JSONDecoder().decode(QuestionList.self, from: data)
            else {
                print("[Error]: Failed to parse Question JSON!")
                DispatchQueue.main.async {
                    failure()
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(questionList)
            }
        }

        task.resume()
    }
}
