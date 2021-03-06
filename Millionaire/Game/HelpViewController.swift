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

class HelpViewController: UIViewController, HelpViewProtocol {

    weak var delegate: HelpDelegate?
    
    var mainView: UIView { return view }
    let stackViewButtonsHelp = UIStackView()
    lazy var backdropView = UIView(frame: self.view.bounds)
    let menuView = UIView()
    let menuHeight = UIScreen.main.bounds.height / 4
    var isPresenting = false
    
    init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let _ = HelpViewControllerFacade(helpViewProtocol: self)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        backdropView.addGestureRecognizer(tapGesture)
    
        showButtonsHelp()
    }
    
    func showButtonsHelp() {
        guard let gameSession = Game.shared.gameSession else { return }
        
        if !gameSession.callFriend {
            let btn1 = HelpButton()
            btn1.tag = EnumHelpButton.HelpFriend.rawValue
            btn1.setTitle("Звонок другу 🙋‍♂️", for: .normal)
            btn1.addTarget(self, action: #selector(didTapTookHint(sender:)), for: .touchUpInside)
            stackViewButtonsHelp.addArrangedSubview(btn1)
        }
        
        if !gameSession.fiftyFifty {
            let btn2 = HelpButton()
            btn2.tag = EnumHelpButton.RemoveIncorrectAnswers.rawValue
            btn2.setTitle("Убрать 2 неверных ответа", for: .normal)
            btn2.addTarget(self, action: #selector(didTapTookHint(sender:)), for: .touchUpInside)
            stackViewButtonsHelp.addArrangedSubview(btn2)
        }
    }
    
    @objc func didTapTookHint(sender: UIButton) {
        dismiss(animated: true) {
            switch sender.tag {
            case EnumHelpButton.HelpFriend.rawValue:
                self.delegate?.didTapHint(with: .callFriend)
            case EnumHelpButton.RemoveIncorrectAnswers.rawValue:
                self.delegate?.didTapHint(with: .fiftyFifty)
            default:
                break
            }
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}

extension HelpViewController: UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        guard let toVC = toViewController else { return }
        isPresenting = !isPresenting
        
        if isPresenting == true {
            containerView.addSubview(toVC.view)
            
            menuView.frame.origin.y += menuHeight
            backdropView.alpha = 0
            
            UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut], animations: {
                self.menuView.frame.origin.y -= self.menuHeight
                self.backdropView.alpha = 1
            }, completion: { (finished) in
                transitionContext.completeTransition(true)
            })
        } else {
            UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut], animations: {
                self.menuView.frame.origin.y += self.menuHeight
                self.backdropView.alpha = 0
            }, completion: { (finished) in
                transitionContext.completeTransition(true)
            })
        }
    }
}
