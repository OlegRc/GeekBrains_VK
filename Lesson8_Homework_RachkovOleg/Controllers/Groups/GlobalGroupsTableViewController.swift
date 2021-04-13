//
//  ThirdTableViewController.swift
//  Lesson1_Homework_RachkovOleg
//
//  Created by Олег Рачков on 21.02.2021.
//

import UIKit

class GlobalGroupsTableViewController: UITableViewController {
    
    var parentTableViewController: GroupsTableViewController? = nil
    private let defaultCell = "defaultCell"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        tableView.register(GroupsListTableViewCell.self, forCellReuseIdentifier: defaultCell)
    }
    
    
    func fetchData() { // загрузка демо данных
        globalGroupsArray = globalGroupsNamesArray.map
        {  GroupModel(
                groupName: $0,
                groupLogo: UIImage.init(named: "groupLogo_"+$0)!,
                groupIsLiked: groupsLikesDictionary[$0] ?? false,
                groupLikesCount: groupsLikesCountDictionary[$0] ?? 0
            )
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedGlobalGroupName = globalGroupsNamesArray[indexPath.row]
        groupNamesArray.append(selectedGlobalGroupName) // изменяем демо данные при добавлении группы в выбранные
        globalGroupsNamesArray.remove(at: indexPath.row)
        
        parentTableViewController?.fetchData()
        parentTableViewController?.selectedGroupsArray = groupsArray
        parentTableViewController?.tableView.reloadData()

        transitioningDelegate = nil
    
        navigationController?.popViewController(animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return globalGroupsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: defaultCell, for: indexPath) as! GroupsListTableViewCell
        cell.setup(group: globalGroupsArray[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}

