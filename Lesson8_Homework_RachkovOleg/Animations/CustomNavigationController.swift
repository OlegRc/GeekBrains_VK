//
//  CustomNavigationController.swift
//  Lesson8_Homework_RachkovOleg
//
//  Created by Олег on 23.03.2021.
//

import UIKit


class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    fileprivate let interactiveTransitionAnimator = InteractiveTransitionAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
        let edgePanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(edgePanGestureStarted(_:)))

        view.addGestureRecognizer(edgePanGestureRecognizer)
        
    }
    
    @objc private func edgePanGestureStarted(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        
        
        switch recognizer.state {
        case .began:
            interactiveTransitionAnimator.didStarted = true
            popViewController(animated: true)
        
        case .changed:
            let totalGestureDistance: CGFloat = UIScreen.main.bounds.width / 2
            let distance = recognizer.translation(in: recognizer.view).x
            let relativeDistance = distance / totalGestureDistance
            let progress = max(0, min(1, relativeDistance))
            
            interactiveTransitionAnimator.update(progress)
            interactiveTransitionAnimator.shouldFinish = progress > 0.35
        
        case .ended:
            interactiveTransitionAnimator.didStarted = false
            if interactiveTransitionAnimator.shouldFinish {
                interactiveTransitionAnimator.finish()
            } else {
                interactiveTransitionAnimator.cancel()
            }
        
        case .cancelled:
            interactiveTransitionAnimator.didStarted = false
            interactiveTransitionAnimator.cancel()
        
        default:
            break
        }
        
        
        
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return CustomPushAnimator()
        } else if operation == .pop {
            return CustomPopAnimator()
        }
        return nil
    }

    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        return interactiveTransitionAnimator.didStarted ? interactiveTransitionAnimator : nil
        
    }
    
}


