//
//  AddQuestionViewController.swift
//  Millionaire
//
//  Created by Ilya on 20.06.2021.
//

import UIKit

enum QuestionFieldsTag: Int {
    case questionTitle = -1
    case firstAnswer
    case secondAnswer
    case thirdAnswer
    case fourthAnswer
}

class AddQuestionViewController: UIViewController {
    
    @IBOutlet weak var questionTextField: UITextField! {
        didSet {
            questionTextField.tag = QuestionFieldsTag.questionTitle.rawValue
            questionTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
    }
    
    @IBOutlet weak var firstAnswerTextField: UITextField! {
        didSet {
            firstAnswerTextField.tag = QuestionFieldsTag.firstAnswer.rawValue
            firstAnswerTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
    }
    
    @IBOutlet weak var secondAnswerTextField: UITextField! {
        didSet {
            secondAnswerTextField.tag = QuestionFieldsTag.secondAnswer.rawValue
            secondAnswerTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
    }
    
    @IBOutlet weak var thirdAnswerTextField: UITextField!{
        didSet {
            thirdAnswerTextField.tag = QuestionFieldsTag.thirdAnswer.rawValue
            thirdAnswerTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
    }
    
    @IBOutlet weak var fourthAnswerTextField: UITextField! {
        didSet {
            fourthAnswerTextField.tag = QuestionFieldsTag.fourthAnswer.rawValue
            fourthAnswerTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
    }
    
    @IBOutlet weak var correctAnswerSegmentControl: UISegmentedControl!
    private var question = QuestionBuilder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //для паттерна билдер
    @objc private func textFieldDidChange(textField: UITextField) {
        let text = textField.text ?? ""
        
        switch textField.tag {
        case QuestionFieldsTag.questionTitle.rawValue:
            question.setTitle(text)
        case QuestionFieldsTag.firstAnswer.rawValue:
            question.setFirstAnswer(text)
        case QuestionFieldsTag.secondAnswer.rawValue:
            question.setSecondAnswer(text)
        case QuestionFieldsTag.thirdAnswer.rawValue:
            question.setThirdAnswer(text)
        case QuestionFieldsTag.fourthAnswer.rawValue:
            question.setFourthAnswer(text)
        default:
            break
        }
    }
    
    @IBAction func didTapSaveButton(_ sender: GameButton) {
        
        if correctAnswerSegmentControl.selectedSegmentIndex == -1 {
            self.showAlert(alertText: "Выберите номер правильного варианта ответа!", alertMessage: "")
            return
        }

        if question.check() {
            self.showAlert(alertText: "Заполните поля!", alertMessage: "")
            return
        }
        
        question.setCorerctAnswer(QuestionFieldsTag(rawValue: correctAnswerSegmentControl.selectedSegmentIndex))
        
        let result = question.build()
        Game.shared.addQuestion(model: result)
        dismiss(animated: true, completion: nil)
    }
    
}
