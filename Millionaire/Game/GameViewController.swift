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

final class GameViewController: UIViewController, GameViewProtocol {
   
    weak var delegate: GameViewControllerDelegate?
    
    var mainView: UIView { return view  }
    var progressLabel = UILabel()
    var stackViewTop = UIStackView()
    let titleLabel = UILabel()
    let stackViewAnswerButtons = UIStackView()
    let helpButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapShowHelpVC), for: .touchUpInside)
        return button
    }()
    
    private var isGameOver: Bool = false
    var pressedButton: Bool = false
    var anwserButtons: [GameButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let count = Game.shared.gameSession?.questions.count
        
        Game.shared.gameSession?.currentIndexQuestion.addObserver(self, closure: { [weak self] (currentIndex, _) in
            self?.progressLabel.text = "Текущий вопрос: \(currentIndex) из \(count ?? 0)"
        })
        
        let _ = GameSceneFacade(gameViewProtocol: self)
        showNextQuetion()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        Game.shared.gameSession?.currentIndexQuestion.removeObserver(self)
    }
    
    @objc func didTapShowHelpVC(sender: UIButton) {
        let helpVC = HelpViewController()
        helpVC.delegate = self
        helpVC.modalPresentationStyle = .custom
        present(helpVC, animated: true, completion: nil)
    }
    
    func showNextQuetion() {
        guard let question = delegate?.nextQuestion() else {
            gameOver()
            return
        }
        
        let count = question.answerOptions.count
        
        titleLabel.text = question.questionTitle
        
        stackViewAnswerButtons.subviews.forEach { $0.removeFromSuperview() }
        
        for i in 0..<count {
            let answerButton = GameButton()
            answerButton.setTitle("\(question.answerOptions[i])", for: .normal)
            answerButton.addTarget(self, action: #selector(didTapChooseAnswer(sender:)), for: .touchUpInside)
            
            stackViewAnswerButtons.addArrangedSubview(answerButton)
        }
    }
    
    @objc func didTapChooseAnswer(sender: UIButton) {
        guard let question = delegate?.getCurrentQuestion(),
              !isGameOver,
              !pressedButton else { return }
        
        if let titleButtonLabel = sender.titleLabel?.text, titleButtonLabel == question.correctAnswer  {
            pressedButton = true
            sender.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.showNextQuetion()
                self.pressedButton = false
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
            
            let currentButton = stackViewAnswerButtons.subviews.map { $0 as? GameButton}
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
                    stackViewAnswerButtons.subviews.first { subView in
                        if let answerButton = subView as? GameButton,
                           answerButton.titleLabel?.text == variant {
                            stackViewAnswerButtons.removeArrangedSubview(answerButton)
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
