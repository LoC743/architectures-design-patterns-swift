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
    
    func saveTasks(_ tasks: [Task]) {
        do {
            let data: Memento = try encoder.encode(tasks)
            UserDefaults.standard.setValue(data, forKey: key)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadTasks() -> [Task] {
        guard let data: Memento = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        
        do {
            return try decoder.decode([Task].self, from: data)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}

