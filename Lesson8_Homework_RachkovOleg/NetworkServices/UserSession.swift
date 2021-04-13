//
//  Session.swift
//  Lesson8_Homework_RachkovOleg
//
//  Created by Олег on 24.03.2021.
//

import UIKit

class UserSession {
    var token: String = ""
    var userId: String = ""
    
    private init() { }
    
    static let shared = UserSession()
    
}
