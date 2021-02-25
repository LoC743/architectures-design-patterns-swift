//
//  AddNewQuestionViewController.swift
//  WhoWantsToBeAmillionaire
//
//  Created by Alexey on 22.02.2021.
//

import UIKit

class AddNewQuestionViewController: UIViewController {
    var questionTextField = QuestionTextField()
    var answerATextField = QuestionTextField()
    var answerBTextField = QuestionTextField()
    var answerCTextField = QuestionTextField()
    var answerDTextField = QuestionTextField()
    var correctAnswerSegmentedControl = UISegmentedControl()
    var addButton = UIButton()
    
    weak var delegate: QuestionsTableDelegate?
    
    private lazy var answerTextFields: [QuestionTextField] = {
       return [answerATextField, answerBTextField, answerCTextField, answerDTextField]
    }()
    private let sideOffset = 15
    private lazy var answers: [String] = {
        return [
            answerATextField.text ?? "",
            answerBTextField.text ?? "",
            answerCTextField.text ?? "",
            answerDTextField.text ?? ""
        ]
    }()
    private lazy var correctAnswer: String = {
        return answers[correctAnswerSegmentedControl.selectedSegmentIndex]
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background
        
        setupElements()
    }
    
    // MARK: - Настройка UI элементов
    
    private func setupElements() {
        setupQuestionTextField()
        setupAnswerTextFields()
        setupCorrectAnswerSegmentedControl()
        setupAddButton()
    }
    
    private func setupQuestionTextField() {
        view.addSubview(questionTextField)
        
        let topPadding = UIApplication.shared.windows[0].safeAreaInsets.top
        let frame = CGRect(
            x: sideOffset,
            y: Int(topPadding) + 5,
            width: Int(view.bounds.width) - sideOffset*2,
            height: 45
        )
        questionTextField.frame = frame
        questionTextField.textColor = Colors.text
        questionTextField.attributedPlaceholder = NSAttributedString(string: "Текст вопроса...",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: Colors.text])
        questionTextField.addBottomLine(with: Colors.scoreBackground)
    }
    
    private func setupAnswerTextFields() {
        let width = Int(view.bounds.width) - sideOffset*2
        for (index, textField) in answerTextFields.enumerated() {
            view.addSubview(textField)
            
            var y = Int(questionTextField.frame.maxY) + 10
            if index != 0 {
                y = Int(answerTextFields[index - 1].frame.maxY) + 10
            }
            
            let frame = CGRect(
                x: sideOffset,
                y: y,
                width: width,
                height: 45
            )
            textField.frame = frame
            textField.textColor = Colors.text
            textField.attributedPlaceholder = NSAttributedString(string: "Ответ №\(index+1)",
                                                                         attributes: [NSAttributedString.Key.foregroundColor: Colors.text])
            textField.addBottomLine(with: Colors.scoreBackground)
        }
    }
    
    private func setupCorrectAnswerSegmentedControl() {
        view.addSubview(correctAnswerSegmentedControl)
        
        let sideOffset = 15
        let width = Int(view.bounds.width) - sideOffset*2
        let height = 50
        let frame = CGRect(
            x: sideOffset,
            y: Int(answerDTextField.frame.maxY) + 15,
            width: width,
            height: height
        )
        correctAnswerSegmentedControl.frame = frame
        correctAnswerSegmentedControl.backgroundColor = Colors.elementBackground
        correctAnswerSegmentedControl.selectedSegmentTintColor = Colors.scoreBackground
        correctAnswerSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colors.textAlternative], for: .selected)
        correctAnswerSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colors.text], for: .normal)
        
        for (index, _) in answerTextFields.enumerated() {
            correctAnswerSegmentedControl.insertSegment(withTitle: "Ответ \(index + 1)", at: index, animated: false)
        }
        correctAnswerSegmentedControl.selectedSegmentIndex = 0
    }
    
    private func setupAddButton() {
        view.addSubview(addButton)
        
        let width = 150
        let height = 50
        let frame = CGRect(
            x: (Int(view.bounds.width) - width)/2,
            y: Int(correctAnswerSegmentedControl.frame.maxY) + 15,
            width: width,
            height: height
        )
        addButton.frame = frame
        addButton.setTitle("Добавить", for: .normal)
        addButton.setTitleColor(Colors.text, for: .normal)
        addButton.backgroundColor = Colors.elementBackground
        addButton.layer.cornerRadius = CGFloat(height/2)
        addButton.layer.borderWidth = 1
        addButton.layer.borderColor = Colors.text.cgColor
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }

    
    // MARK: - (Action) Добавление ответа
    
    private func checkFields() -> Bool {
        let textFields: [QuestionTextField] = [questionTextField] + answerTextFields
        for textField in textFields {
            if textField.text == "" {
                return false
            }
        }
        
        return true
    }
    
    private func buildQuestion() -> Question {
        let builder = QuestionBuilder()
        builder.set(question: questionTextField.text ?? "")
        builder.set(answerA: answerATextField.text ?? "")
        builder.set(answerB: answerBTextField.text ?? "")
        builder.set(answerC: answerCTextField.text ?? "")
        builder.set(answerD: answerDTextField.text ?? "")
        builder.set(correctAnswerIndex: correctAnswerSegmentedControl.selectedSegmentIndex)
        
        return builder.build()
    }
    
    @objc func addButtonTapped(sender: UIButton!) {
        if checkFields() {
           let question = buildQuestion()
            
            QuestionsStorage.shared.add(question: question)
            delegate?.addToTable(question: question)
            self.dismiss(animated: true, completion: nil)
        } else {
            showAlert(title: "Ой!", message: "Кажется Вы задали не все поля.")
        }

    }
    
}
