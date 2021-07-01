//
//  RandomStrategy.swift
//  Millionaire
//
//  Created by Ilya on 20.06.2021.
//

import Foundation

class RandomStrategy: SequenceStrategy {
    func getQuestion() -> [Question] {
        var questions = [Question]()
        
        fillArray().shuffled().forEach { question in
            questions.append(Question(questionTitle: question.questionTitle,
                                 answerOptions: question.answerOptions.shuffled(),
                                 correctAnswer: question.correctAnswer))
            
        }
        
       return questions
    }
}
