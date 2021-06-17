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
    let segueToHelpVC = "ToHelpVC"
    
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
    
    let stackViewButtonsHelp: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    weak var delegate: GameViewControllerDelegate?
    
    private var isGameOver: Bool = false
    var anwserButtons: [AnswerButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(titleLabel)
        view.addSubview(stackView)
        view.addSubview(stackViewButtonsHelp)
        
        setTitleConstraints()
        setStackViewConstraints()
        setStackViewButtonsHelpConstraints()
        showButtonsHelp()
        showNextQuetion()
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
    
    func setStackViewButtonsHelpConstraints() {
        stackViewButtonsHelp.translatesAutoresizingMaskIntoConstraints = false
        stackViewButtonsHelp.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20).isActive = true
        stackViewButtonsHelp.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        stackViewButtonsHelp.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        stackViewButtonsHelp.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25).isActive = true
        stackViewButtonsHelp.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func showButtonsHelp() {
        let btn1 = HelpButton()
        btn1.tag = GameButton.HelpFriend.rawValue
        btn1.setTitle("Звонок другу 🙋‍♂️", for: .normal)
        btn1.addTarget(self, action: #selector(didTapTookHint(sender:)), for: .touchUpInside)
        
        let btn2 = HelpButton()
        btn2.tag = GameButton.RemoveIncorrectAnswers.rawValue
        btn2.setTitle(" Убрать 2 неверных ответа", for: .normal)
        btn2.addTarget(self, action: #selector(didTapTookHint(sender:)), for: .touchUpInside)
        
        stackViewButtonsHelp.addArrangedSubview(btn1)
        stackViewButtonsHelp.addArrangedSubview(btn2)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case segueToHelpVC:
            if let destination = segue.destination as? HelpViewController {
                destination.delegate = self
            }
        default:
            break
        }
    }
    
    @objc func didTapTookHint(sender: UIButton) {
        
        performSegue(withIdentifier: segueToHelpVC, sender: self)
        
//        guard let question = delegate?.getCurrentQuestion(), !isGameOver else { return }
//
//        switch sender.tag {
//        case GameButton.HelpFriend.rawValue:
////            delegate?.hint(type: .callFriend)
//
////            let currentButton = stackView.subviews.map { $0 as? AnswerButton}
////            let correctAnswer = question.correctAnswer
////
////            var friendAnswer = ""
////
////            if Bool.random() {
////                friendAnswer = correctAnswer
////            } else {
////                let randomAnswer = currentButton
////                    .filter { $0?.titleLabel?.text != correctAnswer }
////                    .randomElement()??.titleLabel?.text ?? "нет ответа"
////
////                friendAnswer = randomAnswer
////            }
////            showAlert(alertText: "Звонок другу", alertMessage: "Друг думает, что: \(friendAnswer)")
////
//        case GameButton.RemoveIncorrectAnswers.rawValue:
////            delegate?.hint(type: .fiftyFifty)
////
////            var del = 0
////            for variant in question.answerOptions {
////                if del < 2, variant != question.correctAnswer {
////                    stackView.subviews.first { subView in
////                        if let answerButton = subView as? AnswerButton,
////                           answerButton.titleLabel?.text == variant {
////                            stackView.removeArrangedSubview(answerButton)
////                            del += 1
////                            return true
////                        } else {
////                            return false
////                        }
////                    }?.removeFromSuperview()
////                }
////            }
//        default:
//            return
//        }
        
//        stackViewButtonsHelp.removeArrangedSubview(sender)
//        sender.removeFromSuperview()
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
            let answerButton = AnswerButton()
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
            
            let currentButton = stackView.subviews.map { $0 as? AnswerButton}
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
                        if let answerButton = subView as? AnswerButton,
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
        
 
    }
    
    
}

