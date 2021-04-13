//
//  NewsListTableViewController.swift
//  Lesson1_Homework_RachkovOleg
//
//  Created by Олег Рачков on 07.03.2021.
//

import UIKit


class NewsListTableViewController: UITableViewController {
    
    private let defaultCell = "defaultCell"
    
    var sectionedFriends: [FriendSection] = []
    var selectedSectionedFriends: [FriendSection] = []
    
    lazy var findFriendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Find", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
                
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        
        tableView.register(NewsListTableViewCell.self, forCellReuseIdentifier: defaultCell)
        
    }
    
    func fetchData() { // загрузка демо данных
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: defaultCell, for: indexPath) as! NewsListTableViewCell
//        cell.setup(user: selectedSectionedFriends[indexPath.section].friends[indexPath.row] )
        return NewsListTableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.width
    }
    
}

