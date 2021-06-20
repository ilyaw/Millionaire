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
    
    var helpView: HelpViewProtocol
    
    init(helpViewProtocol: HelpViewProtocol) {
        
        helpView = helpViewProtocol
        
        helpView.mainView.backgroundColor = .clear
        helpView.mainView.addSubview(helpView.backdropView)
        helpView.mainView.addSubview(helpView.menuView)
        
        configureStackViewButtonsHelp()
        configureBackdropView()
        
        setMenuViewConstraints()
        helpView.menuView.addSubview(helpView.stackViewButtonsHelp)
        setStackViewButtonsHelpConstraints()
    }
    
    private func configureStackViewButtonsHelp() {
        helpView.stackViewButtonsHelp.axis = .vertical
        helpView.stackViewButtonsHelp.distribution = .fillEqually
        helpView.stackViewButtonsHelp.spacing = 10
    }
    
    private func configureBackdropView() {
        helpView.backdropView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    private func setMenuViewConstraints() {
        helpView.menuView.backgroundColor = .clear
        helpView.menuView.translatesAutoresizingMaskIntoConstraints = false
        helpView.menuView.heightAnchor.constraint(equalToConstant: helpView.menuHeight).isActive = true
        helpView.menuView.bottomAnchor.constraint(equalTo: helpView.mainView.bottomAnchor).isActive = true
        helpView.menuView.leadingAnchor.constraint(equalTo: helpView.mainView.leadingAnchor).isActive = true
        helpView.menuView.trailingAnchor.constraint(equalTo: helpView.mainView.trailingAnchor).isActive = true
    }

    private func setStackViewButtonsHelpConstraints() {
        helpView.stackViewButtonsHelp.translatesAutoresizingMaskIntoConstraints = false
        helpView.stackViewButtonsHelp.topAnchor.constraint(equalTo: helpView.menuView.topAnchor, constant: 0).isActive = true
        helpView.stackViewButtonsHelp.leadingAnchor.constraint(equalTo: helpView.mainView.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        helpView.stackViewButtonsHelp.trailingAnchor.constraint(equalTo: helpView.mainView.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        helpView.stackViewButtonsHelp.bottomAnchor.constraint(equalTo: helpView.mainView.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
    }
}
