//
//  SettingsViewController.swift
//  Millionaire
//
//  Created by Ilya on 18.06.2021.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var difficultySegmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        difficultySegmentControl.selectedSegmentIndex = Game.shared.difficulty.rawValue
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
                
        Game.shared.difficulty = Difficulty(rawValue: difficultySegmentControl.selectedSegmentIndex) ?? .easy
    }
    
    @IBAction func didTapSaveButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
