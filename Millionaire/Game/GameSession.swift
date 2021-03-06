//
//  GameSession.swift
//  Millionaire
//
//  Created by Ilya on 15.06.2021.
//

import Foundation


enum Hint {
    case fiftyFifty, callFriend
}

enum Difficulty: Int {
    case easy, hard
}

class Game {
    static let shared = Game()
    
    private(set) var records: [Record] {
        didSet {
            recordsCaretaker.save(array: records)
        }
    }
    
    private(set) var questions: [Question] {
        didSet {
            questionCaretaker.save(array: questions)
        }
    }
    
    
    var difficulty: Difficulty = .easy
    var gameSession: GameSession?
    private let recordsCaretaker = Caretaker<Record>(key: "record")
    private let questionCaretaker = Caretaker<Question>(key: "question")
    
    private init() {
        records = recordsCaretaker.load() ?? []
        questions = questionCaretaker.load() ?? []
    }
    
    func addQuestion(model: Question) {
        questions.append(model)
    }
    
    func addRecord() {
        guard let gameSession = gameSession else { return }
        
        records.append(Record(score: gameSession.currentIndexQuestion.value,
                              callFriend: gameSession.callFriend,
                              removeIncorrectAnswers: gameSession.fiftyFifty,
                              date: Date()))
        
        self.gameSession = nil
    }
}

class GameSession {
    private(set) var callFriend: Bool = false
    private(set) var fiftyFifty: Bool = false
    private(set) var currentIndexQuestion = Observable<Int>(-1)
    
    private var createSequnceStrategy: SequenceStrategy = {
        switch Game.shared.difficulty {
        case .easy:
            return –°onsistentlyStrategy()
        case .hard:
            return RandomStrategy()
        }
    }()
    
    private(set) var questions: [Question]
    
    init() {
        questions = createSequnceStrategy.getQuestion()
    }
}

extension GameSession: GameViewControllerDelegate {
    func hint(type: Hint) {
        switch type {
        case .fiftyFifty:
            fiftyFifty = true
        case .callFriend:
            callFriend = true
        }
    }
    
    func nextQuestion() -> Question? {
        currentIndexQuestion.value += 1
        if currentIndexQuestion.value >= questions.count {
            // alles endet
            return nil
        }
                
        return questions[currentIndexQuestion.value]
    }
    
    func getCurrentQuestion() -> Question {
        return questions[currentIndexQuestion.value]
    }
    
    func didEndGame() {
        Game.shared.addRecord()
    }
}
