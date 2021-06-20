//
//  ResultsTableViewCell.swift
//  Millionaire
//
//  Created by Ilya on 15.06.2021.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {
    static let reuseId = "ResultsTableViewCell"
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var callFriendLabel: UILabel!
    @IBOutlet weak var removeIncorrectAnswersLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(with record: Record) {
        
        dateLabel.text = "Дата игры: \( DateFormatter.localizedString(from: record.date, dateStyle: .medium, timeStyle: .short))"
        scoreLabel.text = "Количество очков: \(record.score)"
        callFriendLabel.text = "Звонок другу: \(record.callFriend ? "Да" : "Нет")"
        removeIncorrectAnswersLabel.text = "Убрать 2 неправильных варианта: \(record.removeIncorrectAnswers ? "Да" : "Нет")"
    }
}
