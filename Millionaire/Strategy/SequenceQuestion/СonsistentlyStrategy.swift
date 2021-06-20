//
//  СonsistentlyStrategy.swift
//  Millionaire
//
//  Created by Ilya on 20.06.2021.
//

import Foundation

class СonsistentlyStrategy: SequenceStrategy {
    func getQuestion() -> [Question] {
        let questions = fillArray()
        return questions
    }
}
