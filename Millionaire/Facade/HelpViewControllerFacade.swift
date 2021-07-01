//
//  HelpViewControllerFacade.swift
//  Millionaire
//
//  Created by Ilya on 20.06.2021.
//

import Foundation
import UIKit

protocol HelpViewProtocol {
    var mainView: UIView { get }
    var stackViewButtonsHelp: UIStackView { get }
    var backdropView: UIView { get }
    var menuView: UIView { get }
    var menuHeight: CGFloat { get }
}

final class HelpViewControllerFacade {
    
    var scene: HelpViewProtocol
    
    init(helpViewProtocol: HelpViewProtocol) {
        
        scene = helpViewProtocol
        
        scene.mainView.backgroundColor = .clear
        scene.mainView.addSubview(scene.backdropView)
        scene.mainView.addSubview(scene.menuView)
        
        configureStackViewButtonsHelp()
        configureBackdropView()
        
        setMenuViewConstraints()
        scene.menuView.addSubview(scene.stackViewButtonsHelp)
        setStackViewButtonsHelpConstraints()
    }
    
    private func configureStackViewButtonsHelp() {
        scene.stackViewButtonsHelp.axis = .vertical
        scene.stackViewButtonsHelp.distribution = .fillEqually
        scene.stackViewButtonsHelp.spacing = 10
    }
    
    private func configureBackdropView() {
        scene.backdropView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    private func setMenuViewConstraints() {
        scene.menuView.backgroundColor = .clear
        scene.menuView.translatesAutoresizingMaskIntoConstraints = false
        scene.menuView.heightAnchor.constraint(equalToConstant: scene.menuHeight).isActive = true
        scene.menuView.bottomAnchor.constraint(equalTo: scene.mainView.bottomAnchor).isActive = true
        scene.menuView.leadingAnchor.constraint(equalTo: scene.mainView.leadingAnchor).isActive = true
        scene.menuView.trailingAnchor.constraint(equalTo: scene.mainView.trailingAnchor).isActive = true
    }

    private func setStackViewButtonsHelpConstraints() {
        scene.stackViewButtonsHelp.translatesAutoresizingMaskIntoConstraints = false
        scene.stackViewButtonsHelp.topAnchor.constraint(equalTo: scene.menuView.topAnchor, constant: 0).isActive = true
        scene.stackViewButtonsHelp.leadingAnchor.constraint(equalTo: scene.mainView.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        scene.stackViewButtonsHelp.trailingAnchor.constraint(equalTo: scene.mainView.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        scene.stackViewButtonsHelp.bottomAnchor.constraint(equalTo: scene.mainView.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
    }
}
