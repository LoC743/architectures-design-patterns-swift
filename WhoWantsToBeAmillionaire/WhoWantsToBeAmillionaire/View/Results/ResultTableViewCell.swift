//
//  ResultTableViewCell.swift
//  WhoWantsToBeAmillionaire
//
//  Created by Alexey on 19.02.2021.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var correctAnswersLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var usedHintsLabel: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
    func configure(with gameSession: GameSession) {
        backgroundColor = Colors.scoreBackground
        
        dateLabel.text = "Дата: \(gameSession.date)"
        correctAnswersLabel.text = "Количество правильных ответов: \(gameSession.correctAnswers)"
        scoreLabel.text = "Заработано денег: \(gameSession.score)"
        usedHintsLabel.text = "Использовано подсказок: \(gameSession.usedHints.count)"
        
        [dateLabel, correctAnswersLabel, scoreLabel, usedHintsLabel].forEach { (label) in
            label?.textColor = Colors.textAlternative
            label?.backgroundColor = Colors.scoreBackground
            label?.sizeToFit()
        }
    }
    
}
