//
//  MainViewController.swift
//  ToDoList
//
//  Created by Alexey on 04.03.2021.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var tasks: [Task] = tasksStorage {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .gainsboro

        setupBarButton()
        setupTableView()
    }
    
    private func setupBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            landscapeImagePhone: nil, style: .plain,
            target: self, action: #selector(addTapped)
        )
        navigationItem.rightBarButtonItem?.tintColor = .gainsboro
    }
    
    @objc func addTapped() {
//        guard let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else { return }
//
//        navigationController?.pushViewController(vc, animated: true)
        
        self.showNewTaskAlert()
    }
}

// MARK: - TableView

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    private func setupTableView() {
        tableView.backgroundColor = .gainsboro
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: TaskTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: TaskTableViewCell.reuseIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.reuseIdentifier, for: indexPath) as! TaskTableViewCell
        
        cell.configure(with: tasks[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        testCell = QuestionTableViewCell()
//        let question: QuestionViewModel = questions[indexPath.row]
//        testCell.configure(with: question)
//
//        let height = testCell.height + 15
//
//        return height
        return 55
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tasks.remove(at: indexPath.row)
            if tasks.isEmpty {
                tableView.reloadData()
            } else {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
}

