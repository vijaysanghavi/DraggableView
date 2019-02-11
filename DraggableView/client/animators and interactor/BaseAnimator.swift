//
//  BaseAnimator.swift
//  DraggableView
//
//  Created by Zycus on 01/02/19.
//  Copyright © 2019 VJ. All rights reserved.
//

import UIKit

enum ModalAnimatedTrasitioningType {
    case present
    case dismiss
}

class BaseAnimator: NSObject {
    
    var transitionType: ModalAnimatedTrasitioningType = .present
    
    func animatePresentingInContext(transitionContext: UIViewControllerContextTransitioning, fromVC: UIViewController, toVC: UIViewController) {
        NSException(name: NSExceptionName.internalInconsistencyException, reason: "\(#function) must be override in a subclass/extension", userInfo: nil).raise()
    }
    
    func animateDismissingInContext(transitionContext: UIViewControllerContextTransitioning, fromVC: UIViewController, toVC: UIViewController) {
        NSException(name: NSExceptionName.internalInconsistencyException, reason: "\(#function) must be override in a subclass/extension", userInfo: nil).raise()
    }
}

extension BaseAnimator: UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval{
        NSException(name:NSExceptionName.internalInconsistencyException, reason:"\(#function) must be overridden in a subclass/extension", userInfo:nil).raise()
        return 0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let from = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let to = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        
        if let from = from, let to = to{
            switch transitionType{
            case .present:
                animatePresentingInContext(transitionContext: transitionContext, fromVC: from, toVC: to)
            case .dismiss:
                animateDismissingInContext(transitionContext: transitionContext, fromVC: from, toVC: to)
            }
        }
    }
}
