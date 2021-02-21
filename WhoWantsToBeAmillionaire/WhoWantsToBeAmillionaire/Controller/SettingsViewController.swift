//
//  SettingsViewController.swift
//  WhoWantsToBeAmillionaire
//
//  Created by Alexey on 21.02.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    var questionsModeSegmentedControl = UISegmentedControl()
    var questionsButton = UIButton()
    var clearResultsButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background
        
        setupElements()
    }
    
    // MARK: - Настройка UI элементов
    
    private func setupElements() {
        let window = UIApplication.shared.windows[0]
        let safeAreaOffset = window.safeAreaInsets.top
        let topOffset = 55
        let buttonHeight = 50
        setupQuestionsModeSegmentedControl(Int(safeAreaOffset))
        setupQuestionsButton(topOffset, buttonHeight)
        setupClearResultsButton(topOffset, buttonHeight)
        setupButtonsStyle(buttonHeight)
    }
    
    private func setupQuestionsModeSegmentedControl(_ topOffset: Int) {
        view.addSubview(questionsModeSegmentedControl)
        
        let sideOffset = 15
        let width = Int(view.bounds.width) - sideOffset*2
        let height = 50
        let frame = CGRect(
            x: sideOffset,
            y: topOffset,
            width: width,
            height: height
        )
        questionsModeSegmentedControl.frame = frame
        questionsModeSegmentedControl.backgroundColor = Colors.elementBackground
        questionsModeSegmentedControl.selectedSegmentTintColor = Colors.scoreBackground
        questionsModeSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colors.textAlternative], for: .selected)
        questionsModeSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colors.text], for: .normal)
        questionsModeSegmentedControl.insertSegment(withTitle: "Последовательно", at: 0, animated: false)
        questionsModeSegmentedControl.insertSegment(withTitle: "Случайно", at: 1, animated: false)
        questionsModeSegmentedControl.selectedSegmentIndex = 0
    }
    
    private func setupQuestionsButton(_ topOffset: Int, _ height: Int) {
        view.addSubview(questionsButton)
        
        let questionsModeSegmentedControlFrame = questionsModeSegmentedControl.frame
        let width = 150
        let xCenter = Int(view.center.x) - (width/2)
        let frame = CGRect(
            x: xCenter,
            y: Int(questionsModeSegmentedControlFrame.maxY) + topOffset,
            width: width,
            height: height
        )
        questionsButton.frame = frame
        questionsButton.setTitle("Вопросы", for: .normal)
        questionsButton.addTarget(self, action: #selector(questionsButtonTapped), for: .touchUpInside)
    }
    
    private func setupClearResultsButton(_ topOffset: Int, _ height: Int) {
        view.addSubview(clearResultsButton)
        
        let questionsButtonFrame = questionsButton.frame
        let width = 250
        let xCenter = Int(view.center.x) - (width/2)
        let frame = CGRect(
            x: xCenter,
            y: Int(questionsButtonFrame.maxY) + topOffset,
            width: width,
            height: height
        )
        clearResultsButton.frame = frame
        clearResultsButton.setTitle("Очистить статистику", for: .normal)
        clearResultsButton.addTarget(self, action: #selector(clearResultsButtonTapped), for: .touchUpInside)
    }
    
    private func setupButtonsStyle(_ buttonHeight: Int) {
        [questionsButton, clearResultsButton].forEach { (button) in
            button.setTitleColor(Colors.text, for: .normal)
            button.backgroundColor = Colors.elementBackground
            button.layer.cornerRadius = CGFloat(buttonHeight/2)
            button.layer.borderWidth = 1
            button.layer.borderColor = Colors.text.cgColor
        }
    }
    
    // MARK: - (Action): Переход к таблице вопросов
    
    @objc func questionsButtonTapped(sender: UIButton!) {
        showAlert(title: "Не готово", message: "Тут должен быть переход к таблице вопросов.")
    }
    
    // MARK: - (Action): Очистка результатов
    
    @objc func clearResultsButtonTapped(sender: UIButton!) {
        Game.shared.clearResults()
        showAlert(title: "Результаты", message: "Статистика очищена.")
    }
}
