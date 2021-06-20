//
//  GameSceneFacade.swift
//  Millionaire
//
//  Created by Ilya on 20.06.2021.
//

import Foundation
import UIKit

protocol GameViewProtocol {
    var progressLabel: UILabel { get }
    var titleLabel: UILabel { get }
    var stackView: UIStackView { get }
    var helpButton: HelpButton { get }
    var mainView: UIView { get }
}

final class GameSceneFacade {
    
    var scene: GameViewProtocol
    
    init(gameViewProtocol: GameViewProtocol) {
        scene = gameViewProtocol
        
        scene.mainView.addSubview(scene.progressLabel)
        scene.mainView.addSubview(scene.titleLabel)
        scene.mainView.addSubview(scene.stackView)
        scene.mainView.addSubview(scene.helpButton)
        
        configureProgressLabel()
        configureTitleLabel()
        configureStackView()
        configureHelpButton()
        
        setProgressLabel()
        setTitleConstraints()
        setStackViewConstraints()
        setHelpButtonConstraints()
    }
    
    private func configureProgressLabel() {
        scene.progressLabel.textAlignment = .center
    }
    
    private func configureTitleLabel() {
        scene.titleLabel.font = UIFont.boldSystemFont(ofSize: 26)
        scene.titleLabel.textAlignment = .center
        scene.titleLabel.numberOfLines = 0
        scene.titleLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func configureStackView() {
        scene.stackView.axis = .vertical
        scene.stackView.distribution = .fillEqually
        scene.stackView.spacing = 20
    }
    
    private func configureHelpButton() {
        scene.helpButton.setTitle("Показать подсказки", for: .normal)
    }
    
    private func setProgressLabel() {
        scene.progressLabel.translatesAutoresizingMaskIntoConstraints = false
        scene.progressLabel.topAnchor.constraint(equalTo: scene.mainView.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        scene.progressLabel.leadingAnchor.constraint(equalTo: scene.mainView.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        scene.progressLabel.trailingAnchor.constraint(equalTo: scene.mainView.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
//        scene.progressLabel.bottomAnchor.constraint(equalTo: scene.mainView.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
    }
    
    private func setTitleConstraints() {
        scene.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        scene.titleLabel.topAnchor.constraint(equalTo: scene.progressLabel.topAnchor, constant: 15).isActive = true
        scene.titleLabel.leadingAnchor.constraint(equalTo: scene.mainView.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        scene.titleLabel.trailingAnchor.constraint(equalTo: scene.mainView.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        scene.titleLabel.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    private func setStackViewConstraints() {
        scene.stackView.translatesAutoresizingMaskIntoConstraints = false
        scene.stackView.topAnchor.constraint(equalTo: scene.titleLabel.bottomAnchor, constant: 20).isActive = true
        scene.stackView.leadingAnchor.constraint(equalTo: scene.mainView.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        scene.stackView.trailingAnchor.constraint(equalTo: scene.mainView.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
    }
    
    private func setHelpButtonConstraints() {
        scene.helpButton.translatesAutoresizingMaskIntoConstraints = false
        scene.helpButton.topAnchor.constraint(equalTo: scene.stackView.bottomAnchor, constant: 25).isActive = true
        scene.helpButton.leadingAnchor.constraint(equalTo: scene.mainView.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        scene.helpButton.trailingAnchor.constraint(equalTo: scene.mainView.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        scene.helpButton.bottomAnchor.constraint(equalTo: scene.mainView.safeAreaLayoutGuide.bottomAnchor, constant: -25).isActive = true
    }
}
