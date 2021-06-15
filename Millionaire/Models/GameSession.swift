//
//  GameSession.swift
//  Millionaire
//
//  Created by Ilya on 15.06.2021.
//

import Foundation

struct GameSession: Codable {
    let score: Int //количество верных ответов
    let callFriend: Bool //использовалась ли подсказка звонок другу
    let removeIncorrectAnswers: Bool //использовалась ли подсказка убрать 2 невреных варианта
    let date: Date
}
