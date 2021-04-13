//
//  FirstTableViewController.swift
//  Lesson1_Homework_RachkovOleg
//
//  Created by Олег Рачков on 21.02.2021.
//

import UIKit
import RealmSwift

class FriendsListTableViewController: UITableViewController, UIViewControllerTransitioningDelegate {
    
    private let defaultCell = "defaultCell"
    
    var friendsArray: [FriendModel] = []
    var sectionedFriends: [FriendSection] = []
    var selectedSectionedFriends: [FriendSection] = []
    
    lazy var findFriendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Find", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
                
        button.addTarget(self, action: #selector(findButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func findButtonTapped() {
        
        let sortingVC =  FriendsFirstLettersPickerViewController()

        sortingVC.pickerViewStrings = ["<все>"] + sectionedFriends.map({String($0.title)})
        sortingVC.modalPresentationStyle = .overCurrentContext
        sortingVC.parentTableView = self
        present(sortingVC, animated: true, completion: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let realm = try? Realm() else {
            return
        }
        
        if realm.objects(RealmFriendModel.self).count > 0 {//до подгрузки списка друзей можно воспользоваться данными из реалма
            friendsArray = []
            realm.objects(RealmFriendModel.self).forEach{ realmFriend in
                let friend = FriendModel.init(id: realmFriend.id, name: realmFriend.name, avatarImageUrlString: realmFriend.avatarImageUrlString)
                friendsArray.append(friend)
            }
            createSectionedFriendsArray()
        }
        
        VKAPIRequests.getUserFriends(userId: UserSession.shared.userId)
        //если строчку выше закомментировать - данные подтянутся из реалма
        
        tableView.register(FriendsListTableViewCell.self, forCellReuseIdentifier: defaultCell)
        
        navigationController?.navigationBar.addSubview(findFriendButton)
        findFriendButton.rightAnchor.constraint(equalTo: (navigationController?.navigationBar.rightAnchor)!).isActive = true
        findFriendButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        findFriendButton.topAnchor.constraint(equalTo: (navigationController?.navigationBar.topAnchor)!).isActive = true
        findFriendButton.bottomAnchor.constraint(equalTo: (navigationController?.navigationBar.bottomAnchor)!).isActive = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadFriendsListData(_:)), name: .friendsListRecieved, object: nil)//оповещение о завершении загрузки данных со списком друзей
    }
    
    @objc private func loadFriendsListData(_ notification: NSNotification) {
        
        guard let friendsArrayFromNetwork = notification.userInfo?["friendsArray"] as? [FriendModel] else {return}
        
        friendsArray = friendsArrayFromNetwork
        
        createRealmObjectFriends(friendsArray: friendsArray)//создание объекта Realm
        
        createSectionedFriendsArray()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    func createSectionedFriendsArray() {
        let emptySectionFriends = [FriendSection]()

        sectionedFriends = friendsArray.reduce(into: emptySectionFriends) {currentSectionFriend, friend in
            guard let firstLetter = friend.name.first else { return }
            if let currentSectionFriendStartingWithLetterIndex = currentSectionFriend.firstIndex(where: {$0.title == firstLetter
            }) {
                
                let oldFriend = currentSectionFriend[currentSectionFriendStartingWithLetterIndex]
                let updatedSection = FriendSection(title: firstLetter, friends: (oldFriend.friends + [friend]) )
                currentSectionFriend[currentSectionFriendStartingWithLetterIndex] = updatedSection
            }
            else {
                let newSection = FriendSection(title: firstLetter, friends: [friend])
                currentSectionFriend.append(newSection)
            }

        }.sorted()

        selectedSectionedFriends = sectionedFriends
    }
    
    func createRealmObjectFriends(friendsArray: [FriendModel]) {//создание объекта Realm
        guard let realm = try? Realm() else { return }
        try? realm.write {
            realm.deleteAll()
        }
        friendsArray.forEach { friend in
            let realmFriend = RealmFriendModel(id: Int(friend.id), name: friend.name, avatarImageUrlString: friend.avatarImageUrlString)
            try? realm.write {
                realm.add(realmFriend)
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        findFriendButton.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        findFriendButton.isHidden = true
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return selectedSectionedFriends.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedSectionedFriends[section].friends.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout()
        let collectionView = FriendsPhotoCollectionViewController(collectionViewLayout: layout)
        collectionView.title =  sectionedFriends[indexPath.section].friends[indexPath.row].name
        
        VKAPIRequests.getUserPhoto(userId: String(sectionedFriends[indexPath.section].friends[indexPath.row].id))
        
        navigationController?.pushViewController(collectionView, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(selectedSectionedFriends[section].title)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: defaultCell, for: indexPath) as! FriendsListTableViewCell
        cell.setup(user: selectedSectionedFriends[indexPath.section].friends[indexPath.row] )
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! FriendsListTableViewCell
        cell.animation()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}
