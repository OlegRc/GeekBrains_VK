//
//  FriendsListTableViewCell.swift
//  Lesson1_Homework_RachkovOleg
//
//  Created by Олег Рачков on 24.02.2021.
//

import UIKit

class GroupsListTableViewCell: UITableViewCell {
    
    typealias VoidClosure = () -> ()
    
    var likeTapped: VoidClosure?

    
    let standardIndend: CGFloat = 10
    
    let groupLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "groupLogo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let groupNameLabelView: UILabel = {
        let labelView = UILabel()
        labelView.text = "Название группы"
        labelView.textAlignment = .left
        labelView.font = UIFont.systemFont(ofSize: 16)
        labelView.translatesAutoresizingMaskIntoConstraints = false
        return labelView
    }()
    
    let likeButtonContainerView: LikeButtonView = {
        let view = LikeButtonView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        subViewsSetup()
    }
    
    func subViewsSetup() {
        
        addSubview(groupLogoImageView)
        groupLogoImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: standardIndend).isActive = true
        groupLogoImageView.topAnchor.constraint(equalTo: topAnchor, constant: standardIndend).isActive = true
        groupLogoImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        groupLogoImageView.heightAnchor.constraint(equalTo: groupLogoImageView.widthAnchor).isActive = true
        
        contentView.addSubview(likeButtonContainerView)
        likeButtonContainerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -standardIndend).isActive = true
        likeButtonContainerView.topAnchor.constraint(equalTo: topAnchor, constant: standardIndend).isActive = true
        likeButtonContainerView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        likeButtonContainerView.heightAnchor.constraint(equalTo: groupLogoImageView.widthAnchor).isActive = true
        
        addSubview(groupNameLabelView)
        groupNameLabelView.rightAnchor.constraint(equalTo: likeButtonContainerView.rightAnchor, constant: -standardIndend).isActive = true
        groupNameLabelView.leftAnchor.constraint(equalTo: groupLogoImageView.rightAnchor, constant: standardIndend).isActive = true
        groupNameLabelView.topAnchor.constraint(equalTo: topAnchor, constant: standardIndend).isActive = true
        groupNameLabelView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -standardIndend).isActive = true
        
        likeButtonContainerView.likeTapped = { [weak self] in
            self?.likeTapped?()
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setup(group: GroupModel) {
        groupNameLabelView.text = group.groupName
        groupLogoImageView.image = group.groupLogo
        
        likeButtonContainerView.isLiked = group.groupIsLiked
        likeButtonContainerView.likesCount = group.groupLikesCount
        likeButtonContainerView.objectId = group.groupName
        likeButtonContainerView.setLikeButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
