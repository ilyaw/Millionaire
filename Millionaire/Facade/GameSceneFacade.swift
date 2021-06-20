//
//  GameSceneFacade.swift
//  Millionaire
//
//  Created by Ilya on 20.06.2021.
//

import Foundation
import UIKit

protocol GameViewProtocol {
    var titleLabel: UILabel { get }
    var stackView: UIStackView { get }
    var helpButton: HelpButton { get }
    var mainView: UIView { get }
}

final class GameSceneFacade {
    
    var gameScene: GameViewProtocol
    
    
    init(gameViewProtocol: GameViewProtocol) {
        gameScene = gameViewProtocol
        
        gameScene.mainView.addSubview(gameScene.titleLabel)
        gameScene.mainView.addSubview(gameScene.stackView)
        gameScene.mainView.addSubview(gameScene.helpButton)
        
        configureTitleLabel()
        configureStackView()
        configureHelpButton()
        
        setTitleConstraints()
        setStackViewConstraints()
        setHelpButtonConstraints()
    }
    
    private func configureTitleLabel() {
        gameScene.titleLabel.font = UIFont.boldSystemFont(ofSize: 26)
        gameScene.titleLabel.textAlignment = .center
        gameScene.titleLabel.numberOfLines = 0
        gameScene.titleLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func configureStackView() {
        gameScene.stackView.axis = .vertical
        gameScene.stackView.distribution = .fillEqually
        gameScene.stackView.spacing = 20
    }
    
    private func configureHelpButton() {
        gameScene.helpButton.setTitle("Показать подсказки", for: .normal)
    }
    
    
    private func setHelpButtonConstraints() {
        gameScene.helpButton.translatesAutoresizingMaskIntoConstraints = false
        gameScene.helpButton.topAnchor.constraint(equalTo: gameScene.stackView.bottomAnchor, constant: 25).isActive = true
        gameScene.helpButton.leadingAnchor.constraint(equalTo: gameScene.mainView.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        gameScene.helpButton.trailingAnchor.constraint(equalTo: gameScene.mainView.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        gameScene.helpButton.bottomAnchor.constraint(equalTo: gameScene.mainView.safeAreaLayoutGuide.bottomAnchor, constant: -25).isActive = true
    }
    
    private func setTitleConstraints() {
        gameScene.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        gameScene.titleLabel.topAnchor.constraint(equalTo: gameScene.mainView.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        gameScene.titleLabel.leadingAnchor.constraint(equalTo: gameScene.mainView.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        gameScene.titleLabel.trailingAnchor.constraint(equalTo: gameScene.mainView.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        gameScene.titleLabel.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    private func setStackViewConstraints() {
        gameScene.stackView.translatesAutoresizingMaskIntoConstraints = false
        gameScene.stackView.topAnchor.constraint(equalTo: gameScene.titleLabel.bottomAnchor, constant: 20).isActive = true
        gameScene.stackView.leadingAnchor.constraint(equalTo: gameScene.mainView.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        gameScene.stackView.trailingAnchor.constraint(equalTo: gameScene.mainView.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
    }
}
