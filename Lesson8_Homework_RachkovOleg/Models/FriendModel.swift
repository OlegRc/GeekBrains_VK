//
//  UserModel.swift
//  Lesson1_Homework_RachkovOleg
//
//  Created by Олег Рачков on 24.02.2021.
//

import UIKit

struct FriendModel {
    
    let id: Int
    let name: String
    
    let avatarImage: UIImage = UIImage.init(named: "photoPlaceholder")!
    let avatarImageUrlString: String
    
}

struct FriendSection: Comparable {
    
    let title: Character
    let friends: [FriendModel]
    
    static func < (lhs: FriendSection, rhs: FriendSection) -> Bool {
        lhs.title < rhs.title
    }
    static func == (lhs: FriendSection, rhs: FriendSection) -> Bool {
        lhs.title == rhs.title
    }
    
}
