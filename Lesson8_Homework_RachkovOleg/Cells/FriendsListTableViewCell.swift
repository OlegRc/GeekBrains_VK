//
//  FriendsListTableViewCell.swift
//  Lesson1_Homework_RachkovOleg
//
//  Created by Олег Рачков on 24.02.2021.
//

import UIKit

class FriendsListTableViewCell: UITableViewCell {
    let standardIndend: CGFloat = 10
    
    let shadowContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.75
        view.layer.shadowRadius = 8
        view.layer.shadowOffset = CGSize.zero
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let friendsAvatarImageView: ImageLoader = {
        let imageView = ImageLoader()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    let friendsNameLabelView: UILabel = {
        let labelView = UILabel()
        labelView.text = "Фамилия Имя"
        labelView.textAlignment = .right
        labelView.font = UIFont.systemFont(ofSize: 16)
        labelView.translatesAutoresizingMaskIntoConstraints = false
        return labelView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        subViewsSetup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shadowContainerView.layer.cornerRadius = friendsAvatarImageView.bounds.width / 2
        friendsAvatarImageView.layer.cornerRadius = friendsAvatarImageView.bounds.width / 2
    }
    
    
    
    func subViewsSetup() {
        contentView.addSubview(shadowContainerView)
        shadowContainerView.addSubview(friendsAvatarImageView)
        addSubview(friendsNameLabelView)
        
        let tapGestureRecognizer = UITapGestureRecognizer()
        tapGestureRecognizer.addTarget(self, action: #selector(friendsAvatarTapped))
        friendsAvatarImageView.addGestureRecognizer(tapGestureRecognizer)
        

        shadowContainerView.leftAnchor.constraint(equalTo: leftAnchor, constant: standardIndend).isActive = true
        shadowContainerView.topAnchor.constraint(equalTo: topAnchor, constant: standardIndend).isActive = true
        shadowContainerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -standardIndend).isActive = true
        shadowContainerView.widthAnchor.constraint(equalTo: friendsAvatarImageView.heightAnchor).isActive = true
        
        friendsAvatarImageView.leftAnchor.constraint(equalTo: shadowContainerView.leftAnchor).isActive = true
        friendsAvatarImageView.topAnchor.constraint(equalTo: shadowContainerView.topAnchor).isActive = true
        friendsAvatarImageView.widthAnchor.constraint(equalTo: shadowContainerView.widthAnchor).isActive = true
        friendsAvatarImageView.heightAnchor.constraint(equalTo: shadowContainerView.heightAnchor).isActive = true
        
        friendsNameLabelView.rightAnchor.constraint(equalTo: rightAnchor, constant: -standardIndend).isActive = true
        friendsNameLabelView.leftAnchor.constraint(equalTo: friendsAvatarImageView.rightAnchor, constant: standardIndend).isActive = true
        friendsNameLabelView.topAnchor.constraint(equalTo: topAnchor, constant: standardIndend).isActive = true
        friendsNameLabelView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -standardIndend).isActive = true
    }
    
    @objc func friendsAvatarTapped() {
        animateFriendsAvatarTapped()
    }
    
    func animateFriendsAvatarTapped() {
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.values = [1, 0.8, 1]
        animation.keyTimes = [0, 0.8, 1]
        animation.duration = 0.5
        
        shadowContainerView.layer.add(animation, forKey: nil)
        friendsAvatarImageView.layer.add(animation, forKey: nil)
    }
    
    func setup(user: FriendModel) {
        friendsNameLabelView.text = user.name
        guard let avatarUrl = URL(string: user.avatarImageUrlString) else {return}
        friendsAvatarImageView.loadImageWithUrl(avatarUrl)
    }
    
    func animation() {
        opacityAnimation(view: friendsAvatarImageView)
        scaleAnimation(view: friendsAvatarImageView)
    }
    
    func opacityAnimation(view: UIView) { //анимация изменения прозрачности
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 0.75
        view.layer.add(animation, forKey: nil)
    }
    func scaleAnimation(view: UIView) { //анимация изменения размера
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.values = [0.5, 1]
        animation.keyTimes = [0, 1]
        animation.duration = 0.5
        view.layer.add(animation, forKey: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}


