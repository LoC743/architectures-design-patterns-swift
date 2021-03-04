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
    private lazy var task: Task = {
        return taskCaretaker.loadMainTask()
    }()
    
    func addTask(_ newTask: Task, for mainTask: Task) {
        if mainTask.id == task.id {
            task.addSubtask(newTask)
        } else {
            for subTask in task.openAllSubtasks() {
                if subTask.id == mainTask.id {
                    subTask.addSubtask(newTask)
                    break
                }
            }
        }
        
        taskCaretaker.saveMainTask(task)
    }
    
    func removeTask(by id: Int) {
//        for (index, task) in tasks.enumerated() {
//            if task.id == id {
//                tasks.remove(at: index)
//                break
//            }
//        }
    }
    
    func modifyTask(with newTask: Task) {
        var tasksArray: [Task] = task.openAllSubtasks()
        for (index, subTask) in tasksArray.enumerated() {
            if subTask.id == newTask.id {
                tasksArray[index] = newTask
                break
            }
        }
        taskCaretaker.saveMainTask(task)
    }
    
    func getMainTask() -> Task {
       return task
    }
    
    func getMaxId() -> Int {
        var maxID = 0
        
        for subTask in task.openAllSubtasks() {
            if subTask.id > maxID {
                maxID = subTask.id
            }
        }

        return maxID + 1
    }
}
