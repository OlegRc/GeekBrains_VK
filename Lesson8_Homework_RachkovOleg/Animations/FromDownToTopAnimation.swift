//
//  File.swift
//  Lesson8_Homework_RachkovOleg
//
//  Created by Олег Рачков on 21.03.2021.
//

import UIKit

class FromDownToTopAnimation: NSObject, UIViewControllerAnimatedTransitioning {

    private let animationDuration: TimeInterval = 0.5
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let sourceController = transitionContext.viewController(forKey: .from),
              let destinationController = transitionContext.viewController(forKey: .to) else {
            return
        }
        
        transitionContext.containerView.addSubview(destinationController.view)
        destinationController.view.frame = sourceController.view.frame.insetBy(dx:0, dy: sourceController.view.frame.height/2)

        
        
        UIView.animate(withDuration: animationDuration, animations: {
            destinationController.view.frame = sourceController.view.frame
        }) { completed in
            transitionContext.completeTransition(completed)
        }
    
    }

}
