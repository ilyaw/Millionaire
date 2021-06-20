//
//  GameViewController.swift
//  Millionaire
//
//  Created by Ilya on 14.06.2021.
//

import UIKit

protocol GameViewControllerDelegate: AnyObject {
    func hint(type: Hint)
    func nextQuestion() -> Question?
    func getCurrentQuestion() -> Question
    func didEndGame()
}

final class GameViewController: UIViewController {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        return stackView
    }()
    
    let helpButton: HelpButton = {
        let button = HelpButton()
        button.setTitle("Показать подсказки", for: .normal)
        button.addTarget(self, action: #selector(didTapShowHelpVC), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: GameViewControllerDelegate?
    
    private var isGameOver: Bool = false
    var anwserButtons: [GameButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(titleLabel)
        view.addSubview(stackView)
        view.addSubview(helpButton)
        
        setTitleConstraints()
        setStackViewConstraints()
        showNextQuetion()
        setHelpButtonConstraints()
    }
    
    func setHelpButtonConstraints() {
        helpButton.translatesAutoresizingMaskIntoConstraints = false
        helpButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 25).isActive = true
        helpButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        helpButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        helpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25).isActive = true
    }
    
    func setTitleConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func setStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
    }
    
    @objc func didTapShowHelpVC(sender: UIButton) {
        let vc = HelpViewController()
        vc.delegate = self
        vc.modalPresentationStyle = .custom
        present(vc, animated: true, completion: nil)
    }
    
    func showNextQuetion() {
        guard let question = delegate?.nextQuestion() else {
            gameOver()
            return
        }
        
        let count = question.answerOptions.count
        
        titleLabel.text = question.questionTitle
        
        stackView.subviews.forEach { $0.removeFromSuperview() }
        
        for i in 0..<count {
            let answerButton = GameButton()
            answerButton.setTitle("\(question.answerOptions[i])", for: .normal)
            answerButton.addTarget(self, action: #selector(didTapChooseAnswer(sender:)), for: .touchUpInside)
            
            stackView.addArrangedSubview(answerButton)
        }
    }
    
    @objc func didTapChooseAnswer(sender: UIButton) {
        guard let question = delegate?.getCurrentQuestion(), !isGameOver else { return }
        
        if let titleButtonLabel = sender.titleLabel?.text, titleButtonLabel == question.correctAnswer  {
            sender.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.showNextQuetion()
            }
        } else {
            isGameOver = true
            sender.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.gameOver()
            }
        }
    }
    
    private func gameOver() {
        delegate?.didEndGame()
        dismiss(animated: true, completion: nil)
    }
}

extension GameViewController: HelpDelegate {
    func didTapHint(with hint: Hint) {
        guard let question = delegate?.getCurrentQuestion(), !isGameOver else { return }
        
        switch hint {
        case .callFriend:
            delegate?.hint(type: .callFriend)
            
            let currentButton = stackView.subviews.map { $0 as? GameButton}
            let correctAnswer = question.correctAnswer
            
            var friendAnswer = ""
            if Bool.random() {
                friendAnswer = correctAnswer
            } else {
                let randomAnswer = currentButton
                    .filter { $0?.titleLabel?.text != correctAnswer }
                    .randomElement()??.titleLabel?.text ?? "нет ответа"
                
                friendAnswer = randomAnswer
            }
            showAlert(alertText: "Звонок другу", alertMessage: "Друг думает, что: \(friendAnswer)")
            
        case .fiftyFifty:
            delegate?.hint(type: .fiftyFifty)
            
            var del = 0
            for variant in question.answerOptions {
                if del < 2, variant != question.correctAnswer {
                    stackView.subviews.first { subView in
                        if let answerButton = subView as? GameButton,
                           answerButton.titleLabel?.text == variant {
                            stackView.removeArrangedSubview(answerButton)
                            del += 1
                            return true
                        } else {
                            return false
                        }
                    }?.removeFromSuperview()
                }
            }
        }
        
        if let gameSession = Game.shared.gameSession {
            if gameSession.callFriend && gameSession.fiftyFifty {
                helpButton.removeFromSuperview()
                stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
            }
        }
        
    }
}

extension GameViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfSizePresentationController(presentedViewController: presented, presenting: presentingViewController)
    }
}

class HalfSizePresentationController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let bounds = containerView?.bounds else { return .zero }
        return CGRect(x: 0, y: bounds.height / 2, width: bounds.width, height: bounds.height / 2)
    }
}
