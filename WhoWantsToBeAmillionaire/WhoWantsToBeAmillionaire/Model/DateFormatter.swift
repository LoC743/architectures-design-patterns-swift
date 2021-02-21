//
//  DateFormatter.swift
//  WhoWantsToBeAmillionaire
//
//  Created by Alexey on 20.02.2021.
//

import Foundation

let globalDateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
    return dateFormatter
}()
