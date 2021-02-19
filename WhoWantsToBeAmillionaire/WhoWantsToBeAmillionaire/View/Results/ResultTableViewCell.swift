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
    
    func configure(with gameResult: GameResult) {
        backgroundColor = Colors.scoreBackground
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
        let date = dateFormatter.string(from: gameResult.date)
        
        dateLabel.text = "Дата: \(date)"
        correctAnswersLabel.text = "Количество правильных ответов: \(gameResult.correctAnswersCount)"
        scoreLabel.text = "Заработано денег: \(gameResult.score)"
        usedHintsLabel.text = "Использовано подсказок: \(gameResult.usedHintsCount)"
        
        [dateLabel, correctAnswersLabel, scoreLabel, usedHintsLabel].forEach { (label) in
            label?.textColor = Colors.textAlternative
            label?.backgroundColor = Colors.scoreBackground
            label?.sizeToFit()
        }
    }
    
}
