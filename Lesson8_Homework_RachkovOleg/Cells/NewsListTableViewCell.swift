//
//  NewsListTableViewCell.swift
//  Lesson1_Homework_RachkovOleg
//
//  Created by Олег Рачков on 07.03.2021.
//

import UIKit

class NewsListTableViewCell: UITableViewCell {
    let standardIndend: CGFloat = 10
    
    
    let newsPhotoView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage.init(named: "newsPhoto")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let newsNameLabelView: UILabel = {
        let view = UILabel()
        view.text = "Название новости"
        view.textAlignment = .left
        view.font = UIFont.systemFont(ofSize: 14)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let newsAuthorPhotoImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "photoPlaceholder")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let newsAuthorNameLabelView: UILabel = {
        let view = UILabel()
        view.text = "Автор новости"
        view.font = UIFont.systemFont(ofSize: 14)
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let newsTimeStampLabelView: UILabel = {
        let view = UILabel()
        view.text = "Сегодня в 11:50"
        view.font = UIFont.systemFont(ofSize: 12)
        view.textColor = .lightGray
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let newsLikeButtonView: LikeButtonView = {
        let view = LikeButtonView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let newsCommentButtonView: CommentButtonView = {
        let view = CommentButtonView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let newsRepostButtonView: RepostButtonView = {
        let view = RepostButtonView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let newsViewsIndicatorImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage.init(named: "viewsIcon")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let newsViewsIndicatorLabelView: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.font = UIFont.systemFont(ofSize: 10)
        view.textColor = .lightGray
        view.text = String(Int.random(in: 0...999))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        subViewsSetup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func subViewsSetup() {
        
        addSubview(newsAuthorPhotoImageView)
        newsAuthorPhotoImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: standardIndend).isActive = true
        newsAuthorPhotoImageView.topAnchor.constraint(equalTo: topAnchor, constant: standardIndend).isActive = true
        newsAuthorPhotoImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        newsAuthorPhotoImageView.heightAnchor.constraint(equalTo: newsAuthorPhotoImageView.widthAnchor).isActive = true
        
        addSubview(newsAuthorNameLabelView)
        newsAuthorNameLabelView.leftAnchor.constraint(equalTo: newsAuthorPhotoImageView.rightAnchor, constant: standardIndend).isActive = true
        newsAuthorNameLabelView.rightAnchor.constraint(equalTo: rightAnchor, constant: -standardIndend).isActive = true
        newsAuthorNameLabelView.topAnchor.constraint(equalTo: newsAuthorPhotoImageView.topAnchor).isActive = true
        newsAuthorNameLabelView.heightAnchor.constraint(equalToConstant: 20).isActive = true
       
        addSubview(newsTimeStampLabelView)
        newsTimeStampLabelView.leftAnchor.constraint(equalTo: newsAuthorPhotoImageView.rightAnchor, constant: standardIndend).isActive = true
        newsTimeStampLabelView.rightAnchor.constraint(equalTo: rightAnchor, constant: -standardIndend).isActive = true
        newsTimeStampLabelView.bottomAnchor.constraint(equalTo: newsAuthorPhotoImageView.bottomAnchor).isActive = true
        newsTimeStampLabelView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        addSubview(newsNameLabelView)
        newsNameLabelView.rightAnchor.constraint(equalTo: rightAnchor, constant: -standardIndend).isActive = true
        newsNameLabelView.leftAnchor.constraint(equalTo: leftAnchor, constant: standardIndend).isActive = true
        newsNameLabelView.topAnchor.constraint(equalTo: newsAuthorPhotoImageView.bottomAnchor, constant: standardIndend).isActive = true
        newsNameLabelView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        contentView.addSubview(newsLikeButtonView)
        newsLikeButtonView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -standardIndend).isActive = true
        newsLikeButtonView.leftAnchor.constraint(equalTo: leftAnchor, constant: standardIndend).isActive = true
        newsLikeButtonView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        newsLikeButtonView.widthAnchor.constraint(equalTo: newsLikeButtonView.heightAnchor).isActive = true
        
        contentView.addSubview(newsCommentButtonView)
        newsCommentButtonView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -standardIndend).isActive = true
        newsCommentButtonView.leftAnchor.constraint(equalTo: newsLikeButtonView.rightAnchor, constant: standardIndend*4).isActive = true
        newsCommentButtonView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        newsCommentButtonView.widthAnchor.constraint(equalTo: newsLikeButtonView.heightAnchor).isActive = true
        
        contentView.addSubview(newsRepostButtonView)
        newsRepostButtonView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -standardIndend).isActive = true
        newsRepostButtonView.leftAnchor.constraint(equalTo: newsCommentButtonView.rightAnchor, constant: standardIndend*4).isActive = true
        newsRepostButtonView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        newsRepostButtonView.widthAnchor.constraint(equalTo: newsLikeButtonView.heightAnchor).isActive = true
        
        addSubview(newsViewsIndicatorLabelView)
        newsViewsIndicatorLabelView.rightAnchor.constraint(equalTo: rightAnchor, constant: -standardIndend).isActive = true
        newsViewsIndicatorLabelView.centerYAnchor.constraint(equalTo: newsRepostButtonView.centerYAnchor).isActive = true
        newsViewsIndicatorLabelView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        newsViewsIndicatorLabelView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        addSubview(newsViewsIndicatorImageView)
        newsViewsIndicatorImageView.rightAnchor.constraint(equalTo: newsViewsIndicatorLabelView.leftAnchor, constant: -standardIndend).isActive = true
        newsViewsIndicatorImageView.centerYAnchor.constraint(equalTo: newsViewsIndicatorLabelView.centerYAnchor).isActive = true
        newsViewsIndicatorImageView.heightAnchor.constraint(equalTo: newsViewsIndicatorLabelView.heightAnchor).isActive = true
        newsViewsIndicatorImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        addSubview(newsPhotoView)
        newsPhotoView.leftAnchor.constraint(equalTo: leftAnchor, constant: standardIndend).isActive = true
        newsPhotoView.topAnchor.constraint(equalTo: newsNameLabelView.bottomAnchor, constant: standardIndend).isActive = true
        newsPhotoView.rightAnchor.constraint(equalTo: rightAnchor, constant: -standardIndend).isActive = true
        newsPhotoView.bottomAnchor.constraint(equalTo: newsLikeButtonView.topAnchor, constant: -standardIndend).isActive = true
        
    }
    
    func setup(user: FriendModel) {
        newsNameLabelView.text = user.name
        newsPhotoView.image = user.avatarImage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

