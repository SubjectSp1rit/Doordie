//
//  SlideTabBarTransitionAnimator.swift
//  Doordie
//
//  Created by Arseniy on 21.03.2025.
//

import UIKit

class SlideTabBarTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    // MARK: - Constants
    private enum Constants {
        enum Animation {
            static let duration: TimeInterval = 0.4
        }
    }
    
    private let direction: SlideDirection

    // MARK: - Lifecycle
    init(direction: SlideDirection) {
        self.direction = direction
        super.init()
    }
    
    // MARK: - Methods
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Constants.Animation.duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
              let toVC   = transitionContext.viewController(forKey: .to) else {
            transitionContext.completeTransition(false)
            return
        }

        let containerView = transitionContext.containerView
        let containerFrame = containerView.frame
        let width = containerFrame.width

        let offset = (direction == .left) ? width : -width

        toVC.view.frame = containerFrame.offsetBy(dx: offset, dy: 0)
        containerView.addSubview(toVC.view)

        UIView.animate(withDuration: Constants.Animation.duration, animations: {
            fromVC.view.frame = containerFrame.offsetBy(dx: -offset, dy: 0)
            toVC.view.frame = containerFrame
        }, completion: { finished in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
