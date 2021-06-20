//
//  MainViewController.swift
//  Millionaire
//
//  Created by Ilya on 14.06.2021.
//

import UIKit

class MainViewController: UIViewController {
    let segueToGameVC = "ToGameVC"
    let segueToShowStatistics = "ToShowRecords"
    let segueToShowSettings = "ToShowSettings"
    let segueAddNewQuestions = "AddNewQuestions"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapNewGame(_ sender: UIButton) {
        Game.shared.gameSession = GameSession()
        performSegue(withIdentifier: segueToGameVC, sender: self)
    }
    
    @IBAction func didTapShowStatistics(_ sender: UIButton) {
        performSegue(withIdentifier: segueToShowStatistics, sender: self)
    }
    
    @IBAction func didTapShowSettings(_ sender: UIButton) {
        performSegue(withIdentifier: segueToShowSettings, sender: self)
    }
    
    @IBAction func didTapAddNewQuestions(_ sender: UIButton) {
        performSegue(withIdentifier: segueAddNewQuestions, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case segueToGameVC:
            if let destination = segue.destination as? GameViewController {
                destination.delegate = Game.shared.gameSession
            }
        default:
            break
        }
    }
}
