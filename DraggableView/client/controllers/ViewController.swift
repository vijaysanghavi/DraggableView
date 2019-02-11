//
//  ViewController.swift
//  DraggableView
//
//  Created by Zycus on 01/02/19.
//  Copyright © 2019 VJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var bottomBar: BottomBar!
    
    var disableInteractivePlayerTrasitioning = false
    
    var nextViewController: NextViewController!
    var presentInteractor: MiniToLargeViewInteractor!
    var dismissInteractor: MiniToLargeViewInteractor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareView()
    }

    func prepareView(){
        
        nextViewController = NextViewController()
        nextViewController.rootViewController = self
        nextViewController.transitioningDelegate = self
        nextViewController.modalPresentationStyle = .fullScreen
        nextViewController.modalTransitionStyle = .coverVertical
        
        presentInteractor = MiniToLargeViewInteractor()
        presentInteractor.attachToViewController(viewController: self, withView: bottomBar, presentViewController: nextViewController)
        dismissInteractor = MiniToLargeViewInteractor()
        dismissInteractor.attachToViewController(viewController: nextViewController, withView: nextViewController.view, presentViewController: nil)
    }

    @IBAction func bottomButtonTapped(_ sender: Any) {
        disableInteractivePlayerTrasitioning = true
        self.present(nextViewController, animated: true) { [unowned self] in
            self.disableInteractivePlayerTrasitioning = false
        }
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = MiniToLargeAnimator()
        animator.initialY = BottomBar.bottomBarHeight
        animator.transitionType = .present
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = MiniToLargeAnimator()
        animator.initialY = BottomBar.bottomBarHeight
        animator.transitionType = .dismiss
        return animator
    }

    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard !disableInteractivePlayerTrasitioning else { return nil }
        return presentInteractor
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard !disableInteractivePlayerTrasitioning else { return nil }
        return dismissInteractor
    }
    
}
