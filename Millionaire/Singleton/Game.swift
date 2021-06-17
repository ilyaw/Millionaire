//
//  Game.swift
//  Millionaire
//
//  Created by Ilya on 15.06.2021.
//

import Foundation

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
