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

class GameSession {
    var callFriend: Bool = false
    var fiftyFifty: Bool = false
    var currentIndexQuestion: Int = -1
    
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
