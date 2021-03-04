//
//  Task.swift
//  ToDoList
//
//  Created by Alexey on 04.03.2021.
//

import Foundation

protocol TaskProtocol {
    func addSubtask(_ newTask: Task)
    func removeSubtask(by id: Int) -> Bool
    func openSubtasks() -> [Task]
}

final class Task: TaskProtocol {
    let id: Int
    var text: String = ""
    var isCompleted: Bool = false
    
    private var subTasks: [Task] = []
    
    func addSubtask(_ newTask: Task) {
        subTasks.append(newTask)
    }
    
    func removeSubtask(by id: Int) -> Bool {
        var isSubTasksContain = false
        var indexToRemove: Int = -1
        for (index, subTask) in subTasks.enumerated() {
            if subTask.id == id {
                print(subTask)
                indexToRemove = index
                isSubTasksContain = true
                break
            }
        }
        
        if isSubTasksContain {
            subTasks.remove(at: indexToRemove)
        }
        
        return isSubTasksContain
    }
    
    func openSubtasks() -> [Task] {
        return subTasks
    }
    
    func openAllSubtasks() -> [Task] {
        var tasks: [Task] = []
        for subTask in subTasks {
            tasks.append(subTask)
            tasks.append(contentsOf: subTask.openSubtasks())
        }
        return tasks
    }
    
    init(text: String) {
        self.id = TaskStorage.shared.getMaxId()
        self.isCompleted = false
        self.text = text
    }
    
    init() {
        self.id = -1
        self.isCompleted = false
        self.text = ""
    }
}

typealias Memento = Data

extension Task: Codable { }

extension Task: CustomStringConvertible {
    var description: String {
        return "\nTask\nid: \(id)\ntext: \(text)\nisCompleted: \(isCompleted)"
    }
}
