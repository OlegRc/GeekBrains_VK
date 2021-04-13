//
//  LikesData.swift
//  Lesson1_Homework_RachkovOleg
//
//  Created by Олег Рачков on 02.03.2021.
//

import UIKit //Демо данные для отображения лайков и их количества

let allGroupsNamesArray = groupNamesArray + globalGroupsNamesArray

var groupsLikesDictionary = allGroupsNamesArray.reduce(into: [String: Bool]()) {
    $0[$1] = false
}

var groupsLikesCountDictionary = allGroupsNamesArray.reduce(into: [String: Int]()) {
    $0[$1] = Int.random(in: 0...999)
}
