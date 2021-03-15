//
//  DateFormatter+Extensions.swift
//  iOSArchitecturesDemo
//
//  Created by Alexey on 11.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import Foundation

extension DateFormatter {
    static var shared: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        
        return formatter
    }()
}
