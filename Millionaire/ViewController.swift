//
//  ViewController.swift
//  Millionaire
//
//  Created by Ilya on 14.06.2021.
//

import UIKit

class ViewController: UIViewController {
    let segueToGameVC = "ToGameVC"
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    let questionCount = getQuestions().count
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapNewGame(_ sender: UIButton) {
        performSegue(withIdentifier: segueToGameVC, sender: self)
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
    func didEndGame(with result: Int) {
        scoreLabel.text = "Последний результат: \(result) из \(questionCount)"
    }
}

