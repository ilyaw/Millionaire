//
//  SequenceStrategy.swift
//  Millionaire
//
//  Created by Ilya on 20.06.2021.
//

import Foundation

protocol SequenceStrategy {
    func getQuestion() -> [Question]
}
