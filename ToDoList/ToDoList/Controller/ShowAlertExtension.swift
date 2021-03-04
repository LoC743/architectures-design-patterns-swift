//
//  ShowAlertExtension.swift
//  ToDoList
//
//  Created by Alexey on 04.03.2021.
//

import UIKit

extension MainViewController {
    func showNewTaskAlert() {
        let alert = UIAlertController(title: "Добавить задачу", message: "", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Задача..."
        }
        
        alert.addAction(UIAlertAction(title: "Добавить", style: .default, handler: { [weak alert, weak self] (_) in
            guard let self = self else { return }
            let textField = alert?.textFields![0]
            
            let taskText = textField?.text ?? ""
            let newTask = Task(text: taskText)
            
            self.tasks.append(newTask)
//            if self.currentTask == nil {
//                
//            } else if let current = self.currentTask {
//                for (index, task) in self.tasks.enumerated() {
//                    if task.id == current.id {
//                        self.tasks[index].addSubtask(newTask)
//                        break
//                    }
//                }
//            }
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
