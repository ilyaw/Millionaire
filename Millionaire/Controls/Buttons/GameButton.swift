//
//  GameButton.swift
//  Millionaire
//
//  Created by Ilya on 14.06.2021.
//

import UIKit

class GameButton: UIButton {

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
        backgroundColor = #colorLiteral(red: 0.4941176471, green: 0.6901960784, blue: 1, alpha: 1)
        titleLabel?.font = UIFont(name: "AvenirNext-DemiBoldItalic", size: 22)
        layer.cornerRadius = 20
    }
}
