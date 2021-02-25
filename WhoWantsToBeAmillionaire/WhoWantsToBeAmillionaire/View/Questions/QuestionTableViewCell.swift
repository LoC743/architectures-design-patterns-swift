//
//  QuestionTableViewCell.swift
//  WhoWantsToBeAmillionaire
//
//  Created by Alexey on 22.02.2021.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {
    var questionLabel = UILabel()
    var answerALabel = UILabel()
    var answerBLabel = UILabel()
    var answerCLabel = UILabel()
    var answerDLabel = UILabel()
    
    public static let reuseCellIdentifier = "QuestionTableViewCell"
    
    private lazy var answerLabels: [UILabel] = {
        return [answerALabel, answerBLabel, answerCLabel, answerDLabel]
    }()
    
    lazy var height: CGFloat = {
        return answerDLabel.frame.maxY
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }
    
    // MARK: - Настройка UI элементов
    
    private func setupCell() {
        backgroundColor = Colors.scoreBackground
    }
    
    private func setupQuestionLabel(with text: String) {
        addSubview(questionLabel)
        
        questionLabel.backgroundColor = Colors.scoreBackground
        questionLabel.numberOfLines = 0
        questionLabel.text = text
        questionLabel.textColor = Colors.textAlternative
        
        let size = getLabelSize(label: questionLabel)
        let origin = CGPoint(x: 10, y: 15)
        let frame = CGRect(origin: origin, size: size)
        questionLabel.frame = frame
    }
    
    private func getLabelSize(label: UILabel) -> CGSize {
        let labelSize: CGSize
        if let labelText = label.text, !labelText.isEmpty {
            labelSize = getLabelSize(text: labelText as NSString, font: label.font)
        } else {
            labelSize = .zero
        }
        return labelSize
    }
    
    private func getLabelSize(text: NSString, font: UIFont) -> CGSize {
        let maxWidth = UIScreen.main.bounds.width - 15
        let textBlock = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
        let rect = text.boundingRect(with: textBlock, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        let width = Double(rect.width)
        let height = Double(rect.height)
        return CGSize(width: ceil(width), height: ceil(height))
    }
    
    private func setupAnsewerLabels(with answers: [String], correctAnswer: String) {
        let x = 10
        let topOffset = 10
        let width = Int(UIScreen.main.bounds.width) - x*2
        let height = 30
        for (index, label) in answerLabels.enumerated() {
            addSubview(label)
            
            var y = Int(questionLabel.frame.maxY) + topOffset
            if index != 0 {
                y = Int(answerLabels[index - 1].frame.maxY) + topOffset
            }
            
            let frame = CGRect(
                x: x,
                y: y,
                width: width,
                height: height
            )
            label.frame = frame
            label.layer.masksToBounds = true
            label.text = answers[index]
            label.textAlignment = .center
            label.backgroundColor = Colors.scoreBackground
            label.textColor = Colors.textAlternative
            label.layer.borderWidth = 0
            
            if answers[index] == correctAnswer {
                label.backgroundColor = .systemGreen
                label.layer.cornerRadius = label.frame.height/4
                label.layer.borderWidth = 1
                label.layer.borderColor = Colors.textAlternative.cgColor
            }
        }
    }
    
    // MARK: - Конфигурация ячейки
    
    func configure(with question: Question) {
        setupQuestionLabel(with: question.text)
        setupAnsewerLabels(with: question.answers, correctAnswer: question.correctAnswer)
    }
}
