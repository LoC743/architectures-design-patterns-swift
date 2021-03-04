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
            let textField = alert?.textFields![0]
            
            let taskText = textField?.text ?? ""
            let task = Task(id: 5, text: taskText, isCompleted: false)
            
            self?.tasks.append(task)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
