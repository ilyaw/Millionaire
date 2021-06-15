//
//  GameViewController.swift
//  Millionaire
//
//  Created by Ilya on 14.06.2021.
//

import UIKit

protocol GameViewControllerDelegate: AnyObject {
    func didEndGame(with result: Int)
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
    
    let stackViewButtonsHelp: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
        
    weak var delegate: GameViewControllerDelegate?
    
    var index: Int = 0
    var score: Int = 0
    var isGameOver: Bool = false
    let questions: [Question] = getQuestions()
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
    
    @objc func didTapTookHint(sender: UIButton) {
        if isGameOver {
            return
        }
        
        let currentQuestion = questions[index]
        
        switch sender.tag {
        case GameButton.HelpFriend.rawValue:
            let currentButton = stackView.subviews.map { $0 as? AnswerButton}
            
            let correctAnswer = questions[index].correctAnswer
            
            if Bool.random() {
                showAlert(alertText: "Звонок другу", alertMessage: "Друг думает, что: \(correctAnswer)")
            } else {
                let randomAnswer = currentButton
                    .filter { $0?.titleLabel?.text != correctAnswer }
                    .randomElement()??.titleLabel?.text ?? "нет ответа"
                    
                showAlert(alertText: "Звонок другу", alertMessage: "Друг думает, что: \(randomAnswer)")
            }
            
        case GameButton.RemoveIncorrectAnswers.rawValue:
            var del = 0
            for variant in currentQuestion.answerOptions {
                if del < 2, variant != currentQuestion.correctAnswer {
                    
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

        default:
            return
        }
        
        stackViewButtonsHelp.removeArrangedSubview(sender)
        sender.removeFromSuperview()
    }
    
    
    func showNextQuetion() {
        if index >= questions.count {
            // alles endet
            gameOver()
            return
        }
        
        let question = questions[index]
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
        if isGameOver {
            return
        }
            
        let question = questions[index]
        
        if let titleButtonLabel = sender.titleLabel?.text, titleButtonLabel == question.correctAnswer  {
            score += 1
            index += 1
            
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
        delegate?.didEndGame(with: score)
        dismiss(animated: true, completion: nil)
    }
}
