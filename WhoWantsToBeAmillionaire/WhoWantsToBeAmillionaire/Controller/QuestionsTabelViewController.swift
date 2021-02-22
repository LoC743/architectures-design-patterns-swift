//
//  QuestionsTabelViewController.swift
//  WhoWantsToBeAmillionaire
//
//  Created by Alexey on 22.02.2021.
//

import UIKit

class QuestionsTabelViewController: UIViewController {
    var addButton = UIButton()
    var tableView = UITableView()
    
    var questions = QuestionsStorage.shared.get()
    
    private let reuseCellIdentifier = "QuestionTableViewCell"
    private var testCell = QuestionTableViewCell()
    private let bottomPadding = UIApplication.shared.windows[0].safeAreaInsets.bottom
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.elementBackground
        
        setupTableView()
        setupAddButton()
    }
}

// MARK: - Настройка TableView

extension QuestionsTabelViewController: UITableViewDelegate, UITableViewDataSource {
    private func setupTableView() {
        view.addSubview(tableView)
        
        let frame = CGRect(
            x: 0,
            y: 0,
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height - bottomPadding
        )
        tableView.frame = frame
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = Colors.elementBackground
        tableView.allowsSelection = false
        tableView.register(QuestionTableViewCell.self, forCellReuseIdentifier: reuseCellIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseCellIdentifier, for: indexPath) as! QuestionTableViewCell
        
        let question = questions[indexPath.row]
        
        cell.configure(with: question)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        testCell = QuestionTableViewCell()
        let question = QuestionsStorage.shared.get()[indexPath.row]
        testCell.configure(with: question)
        
        let height = testCell.height + 15
        
        return height
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            QuestionsStorage.shared.remove(at: indexPath.row)
            questions.remove(at: indexPath.row)
            if questions.isEmpty {
                tableView.reloadData()
            } else {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
}

// MARK: - Настройка кнопки добавить вопрос

extension QuestionsTabelViewController {
    private func setupAddButton() {
        view.addSubview(addButton)
        
        let width: Int = 50
        let height = width
        let xOrigin = (Int(UIScreen.main.bounds.width) - width)/2
        let yOrigin = Int(UIScreen.main.bounds.height - bottomPadding) - 2*height
        
        let frame = CGRect(
            x: xOrigin,
            y: yOrigin,
            width: width,
            height: height
        )
        addButton.frame = frame
        addButton.backgroundColor = Colors.elementBackground
        addButton.tintColor = Colors.scoreBackground
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addButton.layer.cornerRadius = CGFloat(height/2)
        addButton.layer.borderWidth = 1
        addButton.layer.borderColor = Colors.textAlternative.cgColor
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc func addButtonTapped(sender: UIButton!) {
        let addQuestionVC = AddNewQuestionViewController()
        addQuestionVC.delegate = self
        
        self.present(addQuestionVC, animated: true, completion: nil)
    }
}
