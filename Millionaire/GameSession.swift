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

class Game {
    static let shared = Game()
    
    private(set) var records: [Record] {
        didSet {
            recordsCaretaker.saveRecords(records: records)
        }
    }
    
    var gameSession: GameSession?
    private let recordsCaretaker = RecordsCaretaker()
    
    private init() {
        records = recordsCaretaker.loadRecords() ?? []
    }
    
    func addRecord() {
        guard let gameSession = gameSession else { return }
        
        records.append(Record(score: gameSession.currentIndexQuestion,
                              callFriend: gameSession.callFriend,
                              removeIncorrectAnswers: gameSession.fiftyFifty,
                              date: Date()))
        
        self.gameSession = nil
    }
}

class GameSession {
    private(set) var callFriend: Bool = false
    private(set) var fiftyFifty: Bool = false
    fileprivate var currentIndexQuestion: Int = -1
    
    var questions = getQuestions()
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
        currentIndexQuestion += 1
        if currentIndexQuestion >= questions.count {
            // alles endet
            return nil
        }
                
        return questions[currentIndexQuestion]
    }
    
    func getCurrentQuestion() -> Question {
        return questions[currentIndexQuestion]
    }
    
    func didEndGame() {
        Game.shared.addRecord()
    }
}
