//
//  ViewController.swift
//  Millionaire
//
//  Created by Ilya on 14.06.2021.
//

import UIKit

class ViewController: UIViewController {
    let segueToGameVC = "ToGameVC"
    let segueToShowStatistics = "ToShowRecords"
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    let questionCount = getQuestions().count
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapNewGame(_ sender: UIButton) {
        performSegue(withIdentifier: segueToGameVC, sender: self)
    }
    
    @IBAction func didTapShowStatistics(_ sender: UIButton) {
        performSegue(withIdentifier: segueToShowStatistics, sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case segueToGameVC:
            if let destination = segue.destination as? GameViewController {
                destination.delegate = self
            }
        default:
            break
        }
    }
}

extension ViewController: GameViewControllerDelegate {
    func didEndGame(with result: GameSession) {
        scoreLabel.text = "Последний результат: \(result.score) из \(questionCount)"
        Game.shared.addGameSession(with: result)
    }
}

