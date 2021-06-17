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
