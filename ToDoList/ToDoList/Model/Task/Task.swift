//
//  Task.swift
//  ToDoList
//
//  Created by Alexey on 04.03.2021.
//

import Foundation

protocol TaskProtocol {
    mutating func addSubtask(_ newTask: Task)
    mutating func removeSubtask()
    func openSubtasks() -> [Task]
}

struct Task: TaskProtocol {
    let id: Int
    var text: String = ""
    var isCompleted: Bool = false
    
    private var subTasks: [Task] = []
    
    mutating func addSubtask(_ newTask: Task) {
        subTasks.append(newTask)
    }
    
    func removeSubtask() {
        
    }
    
    func openSubtasks() -> [Task] {
        return subTasks
    }
    
    init(text: String) {
        if let newID = TaskStorage.shared.getMaxId() {
            self.id = newID
        } else {
            self.id = 0
        }
        self.isCompleted = false
        self.text = text
    }
}

typealias Memento = Data

extension Task: Codable { }
