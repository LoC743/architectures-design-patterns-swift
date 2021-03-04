//
//  Task.swift
//  ToDoList
//
//  Created by Alexey on 04.03.2021.
//

import Foundation

struct Task {
    var id: Int = -1
    var text: String = ""
    var isCompleted: Bool = false
}


let tasksStorage: [Task] = [
    Task(id: 0, text: "Помыть посуду", isCompleted: false),
    Task(id: 1, text: "Пропылесосить", isCompleted: false),
    Task(id: 2, text: "Полежать", isCompleted: true),
    Task(id: 3, text: "Приготовить ужин", isCompleted: false),
]
