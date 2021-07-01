//
//  QuestionBuilder.swift
//  Millionaire
//
//  Created by Ilya on 21.06.2021.
//

import Foundation
import UIKit

class QuestionBuilder {
    private(set) var questionTitle: String = ""
    private(set) var firstAnswer: String = ""
    private(set) var secondAnswer: String = ""
    private(set) var thirdAnswer: String = ""
    private(set) var fourthAnwser: String = ""
    private(set) var correctAnswer: String = ""
    
    func build() -> Question {
        return Question(questionTitle: questionTitle,
                        answerOptions: [firstAnswer, secondAnswer, thirdAnswer, fourthAnwser],
                        correctAnswer: correctAnswer)
    }
    
    func setTitle(_ title: String) {
        self.questionTitle = title
    }
    
    func setFirstAnswer(_ answer: String) {
        self.firstAnswer = answer
    }
    
    func setSecondAnswer(_ answer: String) {
        self.secondAnswer = answer
    }
    
    func setThirdAnswer(_ answer: String) {
        self.thirdAnswer = answer
    }
    
    func setFourthAnswer(_ answer: String) {
        self.fourthAnwser = answer
    }
    
    func check() -> Bool {
        return questionTitle.isEmpty || firstAnswer.isEmpty ||  secondAnswer.isEmpty ||
            thirdAnswer.isEmpty || fourthAnwser.isEmpty
    }
    
    func setCorerctAnswer(_ indexCorrentAnswer: QuestionFieldsTag?) {
        switch indexCorrentAnswer {
        case .firstAnswer:
            correctAnswer = firstAnswer
        case .secondAnswer:
            correctAnswer = secondAnswer
        case .thirdAnswer:
            correctAnswer = thirdAnswer
        case .fourthAnswer:
            correctAnswer = fourthAnwser
        default:
            break
        }
    }
}
