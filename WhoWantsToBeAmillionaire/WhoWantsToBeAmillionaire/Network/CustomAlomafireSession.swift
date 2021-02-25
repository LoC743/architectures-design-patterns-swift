//
//  CustomAlomafireSession.swift
//  WhoWantsToBeAmillionaire
//
//  Created by Alexey on 25.02.2021.
//

import Alamofire

extension Session {
    static let custom: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 5
        
        let sessionManager = Session(configuration: configuration)
        
        return sessionManager
    }()
}
