//
//  TaskStorage.swift
//  ToDoList
//
//  Created by Alexey on 04.03.2021.
//

import Foundation

class TaskStorage {
    static let shared = TaskStorage()
    private init() { }
    
    private let taskCaretaker = TaskCaretaker()
    private var tasks: [Task] = [] {
        didSet {
            taskCaretaker.saveTasks(tasks)
        }
    }
    
    func addTask(_ task: Task) {
        tasks.append(task)
    }
    
    func removeTask(by id: Int) {
        for (index, task) in tasks.enumerated() {
            if task.id == id {
                tasks.remove(at: index)
                break
            }
        }
    }
    
    func modifyTask(newTask: Task) {
        for (index, task) in tasks.enumerated() {
            if task.id == newTask.id {
                tasks[index] = newTask
                break
            }
        }
    }
    
    func getTasks() -> [Task] {
        return taskCaretaker.loadTasks()
    }
    
    func getMaxId() -> Int? {
        guard tasks.count > 0 else { return nil }
        
        var maxID = tasks[0].id
        
        for task in tasks {
            maxID = task.id > maxID ? task.id : maxID
            for subTask in task.openSubtasks() {
                maxID = subTask.id > maxID ? subTask.id : maxID
            }
        }
        
        return maxID
    }
}
