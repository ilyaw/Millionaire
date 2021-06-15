//
//  Game.swift
//  Millionaire
//
//  Created by Ilya on 15.06.2021.
//

import Foundation

class Game {
    static let shared = Game()
    
    private(set) var gameSessions: [GameSession] {
        didSet {
            recordsCaretaker.saveRecords(records: gameSessions)
        }
    }
    
    private let recordsCaretaker = RecordsCaretaker()
    
    private init() {
        gameSessions = recordsCaretaker.loadRecords() ?? []
    }
    
    func addGameSession(with game: GameSession) {
        gameSessions.append(game)
    }
}
