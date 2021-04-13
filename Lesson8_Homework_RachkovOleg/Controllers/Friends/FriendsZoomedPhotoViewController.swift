//
//  FriendsZoomedPhotoViewController.swift
//  Lesson8_Homework_RachkovOleg
//
//  Created by Олег Рачков on 14.03.2021.
//

import UIKit

class FriendsZoomedPhotoViewController: UIViewController, UIScrollViewDelegate {
    
    var currentPhotoIndex: Int = 1
    
    var userPhotosUrlArray: [String] = []
    
    let photoScrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.isScrollEnabled = true
        return view
    }()
    
    let photoImageView: ImageLoader = {
        let view = ImageLoader()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let nextphotoImageView: ImageLoader = {
        let view = ImageLoader()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    enum CurrentImageView {
        case current
        case next
    }
    
    private var currentImageView: CurrentImageView = .current

    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        subViewsSetup()
    }
    
    private func viewSetup() {
        view.backgroundColor = .black
    }
        
    private func subViewsSetup() {
        photoScrollView.minimumZoomScale = 1
        photoScrollView.maximumZoomScale = 5
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 100, right: 0.0)
        
        photoScrollView.contentInset = contentInsets
        photoScrollView.scrollIndicatorInsets = contentInsets
        
        let currentPhotoURL = URL.init(string: userPhotosUrlArray[currentPhotoIndex])
        nextphotoImageView.loadImageWithUrl(currentPhotoURL!)
        
        view.addSubview(photoScrollView)
        photoScrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        photoScrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        photoScrollView.topAnchor.constraint(equalTo : view.topAnchor, constant: (navigationController?.navigationBar.bounds.height)!*2).isActive = true
        photoScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        photoScrollView.contentLayoutGuide.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        photoScrollView.contentLayoutGuide.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        photoScrollView.contentLayoutGuide.topAnchor.constraint(equalTo : view.topAnchor, constant: (navigationController?.navigationBar.bounds.height)!*2).isActive = true
        photoScrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        photoScrollView.delegate = self
        
        
        photoScrollView.addSubview(nextphotoImageView)
        nextphotoImageView.leftAnchor.constraint(equalTo: photoScrollView.contentLayoutGuide.leftAnchor).isActive = true
        nextphotoImageView.rightAnchor.constraint(equalTo: photoScrollView.contentLayoutGuide.rightAnchor).isActive = true
        nextphotoImageView.centerYAnchor.constraint(equalTo: photoScrollView.contentLayoutGuide.centerYAnchor).isActive = true
        nextphotoImageView.topAnchor.constraint(equalTo: photoScrollView.contentLayoutGuide.topAnchor).isActive = true
        
        photoScrollView.addSubview(photoImageView)
        
        photoImageView.leftAnchor.constraint(equalTo: photoScrollView.contentLayoutGuide.leftAnchor).isActive = true
        photoImageView.rightAnchor.constraint(equalTo: photoScrollView.contentLayoutGuide.rightAnchor).isActive = true
        photoImageView.centerYAnchor.constraint(equalTo: photoScrollView.contentLayoutGuide.centerYAnchor).isActive = true
        photoImageView.topAnchor.constraint(equalTo: photoScrollView.contentLayoutGuide.topAnchor).isActive = true
        
        addRecognizers()
    }

    private func addRecognizers(){
        let swipeLeftGestureRecognizer = UISwipeGestureRecognizer()
        swipeLeftGestureRecognizer.addTarget(self, action: #selector(swipingPhotoLeft))
        swipeLeftGestureRecognizer.direction = .left
        photoImageView.addGestureRecognizer(swipeLeftGestureRecognizer)
        
        let swipeRightGestureRecognizer = UISwipeGestureRecognizer()
        swipeRightGestureRecognizer.addTarget(self, action: #selector(swipingPhotoRight))
        swipeRightGestureRecognizer.direction = .right
        photoImageView.addGestureRecognizer(swipeRightGestureRecognizer)
        
    }

    let animationDuration: Double = 0.3

    @objc func swipingPhotoLeft() {
        guard currentPhotoIndex < userPhotosUrlArray.count - 1 else {
            animateLastPhoto(view: photoImageView)
            animateLastPhoto(view: nextphotoImageView)
            return
        }
        currentImageView = .next
        let newPhotoIndex = currentPhotoIndex + 1
        
        let nextPhotoURL = URL.init(string: userPhotosUrlArray[newPhotoIndex])
        photoImageView.loadImageWithUrl(nextPhotoURL!)
        
        photoImageView.transform = CGAffineTransform(translationX: self.view.bounds.width, y: 200).concatenating(CGAffineTransform(scaleX: 0.5, y: 0.5))

        UIView.animate(withDuration: animationDuration) { [self] in
            nextphotoImageView.transform = CGAffineTransform(translationX: -self.view.bounds.width, y: 0).concatenating(CGAffineTransform(scaleX: 0.5, y: 0.5))
            photoImageView.transform = .identity
        } completion: { [self] _ in
            nextphotoImageView.image = photoImageView.image
            nextphotoImageView.transform = .identity
            photoImageView.transform = .identity
            currentPhotoIndex = newPhotoIndex
        }
    }
    
    @objc func swipingPhotoRight() {
        guard currentPhotoIndex > 0 else {
            animateFirstPhoto(view: photoImageView)
            animateFirstPhoto(view: nextphotoImageView)
            return
        }
        currentImageView = .next
        let newPhotoIndex = currentPhotoIndex - 1
        
        let nextPhotoURL = URL.init(string: userPhotosUrlArray[newPhotoIndex])
        photoImageView.loadImageWithUrl(nextPhotoURL!)

        photoImageView.transform = CGAffineTransform(translationX: -self.view.bounds.width, y: 200).concatenating(CGAffineTransform(scaleX: 0.5, y: 0.5))
        
        
        UIView.animate(withDuration: animationDuration) { [self] in
            nextphotoImageView.transform = CGAffineTransform(translationX: self.view.bounds.width, y: 0).concatenating(CGAffineTransform(scaleX: 0.5, y: 0.5))
            photoImageView.transform = .identity
        } completion: { [self] _ in
            nextphotoImageView.image = photoImageView.image
            nextphotoImageView.transform = .identity
            photoImageView.transform = .identity
            currentPhotoIndex = newPhotoIndex
        }
    }
    
    
    func animateLastPhoto(view: UIView) {//аницация попытки пролистывания последней фотографии

        UIView.animate(withDuration: 0.125, animations: {
            view.transform = CGAffineTransform(translationX: -view.frame.maxX*0.05, y: 0)
        }, completion: { completed in
            UIView.animate(withDuration: 0.125, animations: {
                view.transform = .identity
            })
        }

        )
        
    }
    
    func animateFirstPhoto(view: UIView) { //аницация попытки пролистывания первой фотографии
        UIView.animate(withDuration: 0.125, animations: {
            view.transform = CGAffineTransform(translationX: view.frame.maxX*0.05, y: 0)
        }, completion: { completed in
            UIView.animate(withDuration: 0.125, animations: {
                view.transform = .identity
            })
        }
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let recognizers = navigationController?.view.gestureRecognizers {
            for recognizer in recognizers {
                recognizer.isEnabled = false
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let recognizers = navigationController?.view.gestureRecognizers {
            for recognizer in recognizers {
                recognizer.isEnabled = true
            }
        }
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        if currentImageView == .next { nextphotoImageView.isHidden = true }
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        if scrollView.zoomScale == 1 && currentImageView == .next { nextphotoImageView.isHidden = false }
    }
    
    private var scrollViewOffsetY: CGFloat = 0
    
    private var draggingStartTime = DispatchTime.now()
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollViewOffsetY = scrollView.contentOffset.y
        draggingStartTime = DispatchTime.now()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let draggingSpeed = scrollView.contentOffset.y - scrollViewOffsetY
        
        let draggingEndTime = DispatchTime.now()
        
        let draggingTime = draggingEndTime.uptimeNanoseconds - draggingStartTime.uptimeNanoseconds
        
        if draggingSpeed >= 100 && draggingTime < 150000000 && scrollView.zoomScale == 1 {
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        if currentImageView == .next {
            return self.photoImageView
        } else {
            return self.nextphotoImageView
        }
    }
    
}
