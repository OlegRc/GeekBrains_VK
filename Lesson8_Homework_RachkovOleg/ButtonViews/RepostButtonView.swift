//
//  RepostButtonView.swift
//  Lesson1_Homework_RachkovOleg
//
//  Created by Олег Рачков on 10.03.2021.
//

import UIKit

class RepostButtonView: UIView {
    
    typealias VoidClosure = () -> ()
    
    var likeTapped: VoidClosure?
    
    var isLiked: Bool = false
    var objectId: String = ""
    var likesCount: Int = 0
    
    let likedImageOff: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor.white.withAlphaComponent(0)
        image.image = UIImage.init(named: "repostIcon")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    let likedImageOn: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor.white.withAlphaComponent(0)
        image.image = UIImage.init(named: "repostIcon")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let likesCountLabelView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .center
        return label
    }()

    let likesContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLikeButton()
        
        let tapGestureRecognizer = UITapGestureRecognizer()
        tapGestureRecognizer.addTarget(self, action: #selector(buttonPressed))
        addGestureRecognizer(tapGestureRecognizer)
        
        addSubview(likesContainer)
        likesContainer.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        likesContainer.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        likesContainer.topAnchor.constraint(equalTo: topAnchor).isActive = true
        likesContainer.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        likesContainer.addSubview(likedImageOff)
        likedImageOff.heightAnchor.constraint(equalTo: likesContainer.heightAnchor).isActive = true
        likedImageOff.widthAnchor.constraint(equalTo: likesContainer.widthAnchor).isActive = true
        likedImageOff.centerXAnchor.constraint(equalTo: likesContainer.centerXAnchor).isActive = true
        likedImageOff.centerYAnchor.constraint(equalTo: likesContainer.centerYAnchor).isActive = true
        
        likesContainer.addSubview(likedImageOn)
        likedImageOn.heightAnchor.constraint(equalTo: likesContainer.heightAnchor).isActive = true
        likedImageOn.widthAnchor.constraint(equalTo: likesContainer.widthAnchor).isActive = true
        likedImageOn.centerXAnchor.constraint(equalTo: likesContainer.centerXAnchor).isActive = true
        likedImageOn.centerYAnchor.constraint(equalTo: likesContainer.centerYAnchor).isActive = true

        likesContainer.addSubview(likesCountLabelView)
        likesCountLabelView.heightAnchor.constraint(equalTo: likesContainer.heightAnchor, multiplier: 0.5).isActive = true
        likesCountLabelView.widthAnchor.constraint(equalTo: likesContainer.widthAnchor, multiplier: 0.5).isActive = true
        likesCountLabelView.leftAnchor.constraint(equalTo: likesContainer.rightAnchor).isActive = true
        likesCountLabelView.centerYAnchor.constraint(equalTo: likesContainer.centerYAnchor).isActive = true
        
    }
    
    @objc func buttonPressed() {
        
        likesCount += (isLiked ?  -1 : 1)
        
        isLiked = !isLiked
        groupsLikesDictionary[objectId] = isLiked // изменяем демо данные при нажатии кнопки лайк
        groupsLikesCountDictionary[objectId] = likesCount
        
        setLikeButton()
        animateLikePressed(view: likesContainer)
        
        likeTapped?()
    }
    
    func setLikeButton() {
        likesCountLabelView.text = String(likesCount)
        if isLiked {
            likedImageOff.isHidden = true
            likedImageOn.isHidden = false
        } else {
            likedImageOff.isHidden = false
            likedImageOn.isHidden = true
        }
    }
    
    func animateLikePressed(view: UIView) {
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.values = [1, 1.3, 1]
        animation.keyTimes = [0, 0.5, 1]
        animation.duration = 0.1
        
        let vibrationGenerator = UIImpactFeedbackGenerator()
        vibrationGenerator.impactOccurred()
        
        view.layer.add(animation, forKey: nil)
    
    }
    
}
