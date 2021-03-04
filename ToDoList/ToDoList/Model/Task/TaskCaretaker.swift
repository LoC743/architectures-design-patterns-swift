//
//  TaskCaretaker.swift
//  ToDoList
//
//  Created by Alexey on 04.03.2021.
//

import Foundation

class TaskCaretaker {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let key = "tasks"
    
    func saveMainTask(_ task: Task) {
        do {
            let data: Memento = try encoder.encode(task)
            UserDefaults.standard.setValue(data, forKey: key)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadMainTask() -> Task {
        guard let data: Memento = UserDefaults.standard.data(forKey: key) else {
            return Task()
        }
        
        do {
            return try decoder.decode(Task.self, from: data)
        } catch {
            print(error.localizedDescription)
            return Task()
        }
    }
}

