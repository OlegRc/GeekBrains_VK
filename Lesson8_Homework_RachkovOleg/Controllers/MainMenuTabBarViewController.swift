//
//  TabBarViewController.swift
//  Lesson1_Homework_RachkovOleg
//
//  Created by Олег Рачков on 21.02.2021.
//

import UIKit
import WebKit

class MainMenuTabBarViewController: UITabBarController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        let firstItem = FriendsListTableViewController()
        firstItem.title = "Friends"
        let secondItem = GroupsTableViewController()
        secondItem.title = "Groups"
        let thirdItem = NewsListTableViewController()
        thirdItem.title = "News"
        self.viewControllers = [firstItem, secondItem, thirdItem]
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Контакты"
    }
    
    override func loadView() {
        super.loadView()
        WKWebView.clean()
    }
    
}
