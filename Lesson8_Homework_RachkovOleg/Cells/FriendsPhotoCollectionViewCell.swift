//
//  FriendsPhotoCollectionViewCell.swift
//  Lesson1_Homework_RachkovOleg
//
//  Created by Олег Рачков on 24.02.2021.
//

import UIKit

class FriendsPhotoCollectionViewCell: UICollectionViewCell {
    
    let standardIndend: CGFloat = 5
    
    var photoUrl: String = ""
    
    let friendsPhotoImageView: ImageLoader = {
        let imageView = ImageLoader()
        imageView.image = UIImage.init(named: "photoPlaceholder")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        subViewSetup()
    }
    
    func subViewSetup(){
        addSubview(friendsPhotoImageView)
        friendsPhotoImageView.leftAnchor.constraint(equalTo: leftAnchor,constant: standardIndend).isActive = true
        friendsPhotoImageView.topAnchor.constraint(equalTo: topAnchor, constant: standardIndend).isActive = true
        friendsPhotoImageView.widthAnchor.constraint(equalTo: widthAnchor, constant: -standardIndend).isActive = true
        friendsPhotoImageView.heightAnchor.constraint(equalTo: heightAnchor,constant: -standardIndend).isActive = true
        
    }
    
    func setup(photoUrl: String) {
        let url = URL.init(string: photoUrl)
        friendsPhotoImageView.loadImageWithUrl(url!)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

