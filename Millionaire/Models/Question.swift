//
//  Question.swift
//  Millionaire
//
//  Created by Ilya on 14.06.2021.
//

import Foundation

struct Question {
    let questionTitle: String
    let answerOptions: [String]
    let correctAnswer: String
}

func getQuestions() -> [Question] {
    var questions: [Question] = []
    
    questions.append(Question(questionTitle: "Где дети ищут подарки утром 1 января?",
                              answerOptions: ["под ёлкой", "под палкой", "под скалкой", "под мухой"].shuffled(),
                              correctAnswer: "под ёлкой"))
    
    questions.append(Question(questionTitle: "Что из перечисленного пирог?",
                              answerOptions: ["кусака", "закаляка", "забияка", "кулебяка"].shuffled(),
                              correctAnswer: "кулебяка"))
    
    questions.append(Question(questionTitle: "Провожают, как известно, по уму, а как встречают?",
                              answerOptions: ["по одёжке" , "по сберкнижке", "по прописке", "по рекомендации"].shuffled(),
                              correctAnswer: "по одёжке"))
    
    questions.append(Question(questionTitle: "Как называют мелководный бассейн, предназначенный для детей?",
                              answerOptions: ["утятник" , "лягушатник", "селёдочник", "тюленник"].shuffled(),
                              correctAnswer: "лягушатник"))
    
    questions.append(Question(questionTitle: "Что, по словам кота Бегемота, он делал, когда его пришли арестовывать?",
                              answerOptions: ["починял примус" , "чистил обувь", "варил кашу", "играл в шахматы"].shuffled(),
                              correctAnswer: "починял примус"))
    
    return questions
}


