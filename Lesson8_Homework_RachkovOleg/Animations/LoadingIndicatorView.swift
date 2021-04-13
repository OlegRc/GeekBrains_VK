//
//  LoadingIndicatorViewController.swift
//  Lesson1_Homework_RachkovOleg
//
//  Created by Олег Рачков on 09.03.2021.
//

import UIKit

class LoadingIndicatorView: UIView {
    
    let dotsContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let firstDotView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let secondDotView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let thirdDotView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        subViewsSetup()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        
        setupDotViews()
        startLoadingAnimation()
    }
    
    func setupDotViews(){
        let frameHeight = frame.size.height
        let cornerRadius = frameHeight / 2
        
        firstDotView.layer.frame.size.width = frameHeight
        firstDotView.layer.cornerRadius = cornerRadius
        
        secondDotView.layer.frame.size.width = frameHeight
        secondDotView.layer.cornerRadius = cornerRadius
        
        thirdDotView.layer.frame.size.width = frameHeight
        thirdDotView.layer.cornerRadius = cornerRadius
        
    }

    func startLoadingAnimation() {
        loadingAnimation(view: firstDotView, beginTime: 0)
        loadingAnimation(view: secondDotView, beginTime: 0.25)
        loadingAnimation(view: thirdDotView, beginTime: 0.5)
    }
    
    func loadingAnimation(view: UIView, beginTime: Double) {
        loadingScaleAnimation(view: view, beginTime: beginTime)
        loadingOpacityAnimation(view: view, beginTime: beginTime)
    }
    
    func loadingScaleAnimation(view: UIView, beginTime: Double) { //анимация изменения размера
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.values = [1, 0.25, 1]
        animation.keyTimes = [0, 0.5, 1]
        animation.duration = 1.5
        animation.repeatCount = .infinity
        animation.beginTime = CACurrentMediaTime() + beginTime
        view.layer.add(animation, forKey: nil)
    }
    
    func loadingOpacityAnimation(view: UIView, beginTime: Double) { //анимация изменения прозрачности
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 1
        animation.toValue = 0
        animation.duration = 0.75
        animation.autoreverses = true
        animation.repeatCount = .infinity
        animation.beginTime = CACurrentMediaTime() + beginTime
        view.layer.add(animation, forKey: nil)
    }
    
    func subViewsSetup() {
        addSubview(dotsContainerView)
        dotsContainerView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        dotsContainerView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        dotsContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        dotsContainerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        dotsContainerView.addSubview(firstDotView)
        firstDotView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        firstDotView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        firstDotView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        firstDotView.widthAnchor.constraint(equalTo: firstDotView.heightAnchor).isActive = true
        
        dotsContainerView.addSubview(secondDotView)
        secondDotView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        secondDotView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        secondDotView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        secondDotView.widthAnchor.constraint(equalTo: secondDotView.heightAnchor).isActive = true
        
        dotsContainerView.addSubview(thirdDotView)
        thirdDotView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        thirdDotView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        thirdDotView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        thirdDotView.widthAnchor.constraint(equalTo: thirdDotView.heightAnchor).isActive = true
    }
    
    
    
}
