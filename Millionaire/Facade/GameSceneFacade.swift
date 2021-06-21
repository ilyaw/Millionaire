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
    var stackViewTop: UIStackView { get }
    var stackViewAnswerButtons: UIStackView { get }
    var helpButton: UIButton { get }
    var mainView: UIView { get }
}

final class GameSceneFacade {
    
    var scene: GameViewProtocol
    
    init(gameViewProtocol: GameViewProtocol) {
        scene = gameViewProtocol
        
        scene.mainView.addSubview(scene.stackViewTop)
        scene.mainView.addSubview(scene.titleLabel)
        scene.mainView.addSubview(scene.stackViewAnswerButtons)
        scene.mainView.addSubview(scene.helpButton)
        
        scene.stackViewTop.addArrangedSubview(scene.progressLabel)
        scene.stackViewTop.addArrangedSubview(scene.helpButton)
        
        configureProgressLabel()
        configureStackViewTop()
        configureTitleLabel()
        configureStackView()
        configureHelpButton()
        
        setStackViewTop()
        setTitleConstraints()
        setStackViewConstraints()
    }
    
    private func configureProgressLabel() {
        scene.progressLabel.font = UIFont.systemFont(ofSize: 15)
        scene.progressLabel.textAlignment = .center
    }
    
    private func configureStackViewTop() {
        scene.stackViewTop.axis = .horizontal
        scene.stackViewTop.distribution = .fillEqually
    }
    
    private func configureTitleLabel() {
        scene.titleLabel.font = UIFont.boldSystemFont(ofSize: 26)
        scene.titleLabel.textAlignment = .center
        scene.titleLabel.numberOfLines = 0
        scene.titleLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func configureStackView() {
        scene.stackViewAnswerButtons.axis = .vertical
        scene.stackViewAnswerButtons.distribution = .fillEqually
        scene.stackViewAnswerButtons.spacing = 20
    }
    
    private func configureHelpButton() {
        scene.helpButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 100, bottom: 0, right: 0)
        scene.helpButton.setImage(UIImage(named: "icons8-ask-question-30"), for: .normal)
    }
    
    private func setStackViewTop() {
        scene.stackViewTop.translatesAutoresizingMaskIntoConstraints = false
        scene.stackViewTop.topAnchor.constraint(equalTo: scene.mainView.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        scene.stackViewTop.leadingAnchor.constraint(equalTo: scene.mainView.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        scene.stackViewTop.trailingAnchor.constraint(equalTo: scene.mainView.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        scene.stackViewTop.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setTitleConstraints() {
        scene.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        scene.titleLabel.topAnchor.constraint(equalTo: scene.stackViewTop.bottomAnchor, constant: 15).isActive = true
        scene.titleLabel.leadingAnchor.constraint(equalTo: scene.mainView.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        scene.titleLabel.trailingAnchor.constraint(equalTo: scene.mainView.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        scene.titleLabel.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    private func setStackViewConstraints() {
        scene.stackViewAnswerButtons.translatesAutoresizingMaskIntoConstraints = false
        scene.stackViewAnswerButtons.topAnchor.constraint(equalTo: scene.titleLabel.bottomAnchor, constant: 20).isActive = true
        scene.stackViewAnswerButtons.leadingAnchor.constraint(equalTo: scene.mainView.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        scene.stackViewAnswerButtons.trailingAnchor.constraint(equalTo: scene.mainView.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        scene.stackViewAnswerButtons.bottomAnchor.constraint(equalTo: scene.mainView.safeAreaLayoutGuide.bottomAnchor, constant: -25).isActive = true
    }
    
}
