//
//  MiniToLargeViewInterator.swift
//  DraggableView
//
//  Created by Zycus on 01/02/19.
//  Copyright © 2019 VJ. All rights reserved.
//

import UIKit

class MiniToLargeViewInteractor: UIPercentDrivenInteractiveTransition {
    
    var viewController: UIViewController!
    var presentViewController: UIViewController!
    var pan: UIPanGestureRecognizer!
    
    var shouldComplete = false
    var lastProgress: CGFloat? = 0.0
    
    func attachToViewController(viewController: UIViewController, withView view: UIView, presentViewController: UIViewController?){
        self.viewController = viewController
        self.presentViewController = presentViewController
        pan = UIPanGestureRecognizer(target: self, action: #selector(MiniToLargeViewInteractor.onPan(pan:)))
        view.addGestureRecognizer(pan)
    }
    
    @objc func onPan(pan: UIPanGestureRecognizer)  {
        let translation = pan.translation(in: pan.view?.superview)
        
        //Represents the percentage of the transition that must be completed before allowing to complete.
        let percentThreshold: CGFloat = 0.2
        //Represents the difference between progress that is required to trigger the completion of the transition.
        let automaticOverrideThreshold: CGFloat = 0.03
        
        let screenHeight: CGFloat = UIScreen.main.bounds.size.height - BottomBar.bottomBarHeight
        let dragAmount: CGFloat = (presentViewController == nil) ? screenHeight : -screenHeight
        var progress: CGFloat = translation.y / dragAmount
        
        progress = fmax(progress, 0)
        progress = fmin(progress, 1)
        
        switch pan.state {
        case .began:
            
            if let presentViewController = presentViewController{
                viewController.present(presentViewController, animated: true, completion: nil)
            }else{
                viewController.dismiss(animated: true, completion: nil)
            }
            
        case .changed:
            guard let lastProgress = lastProgress else {return}
            
            if lastProgress > progress{
                shouldComplete = false
            }else if progress > lastProgress + automaticOverrideThreshold{
                shouldComplete = true
            }else{
            }
            shouldComplete = progress > percentThreshold
            update(progress)
            
        case .ended, .cancelled:
            if pan.state == .cancelled || shouldComplete == false{
                cancel()
            }else{
                finish()
            }
            
        default:
            break
        }
    }
}
