//
//  RealmUserModel.swift
//  Lesson8_Homework_RachkovOleg
//
//  Created by Олег on 12.04.2021.
//

import Foundation
import RealmSwift

class RealmFriendModel: Object {
    @objc dynamic var id: Int = -1
    @objc dynamic var name: String = ""
    @objc dynamic var avatarImageUrlString: String = ""

    convenience init(id: Int, name: String, avatarImageUrlString: String) {
        self.init()
        
        self.id = id
        self.name = name
        self.avatarImageUrlString = avatarImageUrlString
    }
}
