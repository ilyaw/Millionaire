//
//  HelpViewController.swift
//  Millionaire
//
//  Created by Ilya on 16.06.2021.
//

import UIKit

protocol HelpDelegate: AnyObject {
    func didTapHint(with hint: Hint)
}

class HelpViewController: UIViewController {

    weak var delegate: HelpDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        delegate?.didTapHint(with: .callFriend)
    }
    
    /*
     stackViewButtonsHelp.removeArrangedSubview(sender)
     sender.removeFromSuperview()
     */
    

 

}
