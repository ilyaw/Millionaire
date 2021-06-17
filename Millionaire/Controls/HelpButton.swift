//
//  HelpButton.swift
//  Millionaire
//
//  Created by Ilya on 15.06.2021.
//

import UIKit

enum GameButton: Int {
    case HelpFriend = 1
    case RemoveIncorrectAnswers = 2
}

class HelpButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    func setupButton() {
        setTitleColor(.white, for: .normal)
        backgroundColor = #colorLiteral(red: 0.6529653668, green: 0.6184541583, blue: 0, alpha: 1)
        titleLabel?.font = UIFont(name: "AvenirNext-DemiBoldItalic", size: 22)
        layer.cornerRadius = 10
    }
}
