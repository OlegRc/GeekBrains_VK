//
//  SecondTableViewController.swift
//  Lesson1_Homework_RachkovOleg
//
//  Created by Олег Рачков on 21.02.2021.
//

import UIKit

class GroupsTableViewController: UITableViewController, UIViewControllerTransitioningDelegate {

    private let defaultCell = "defaultCell"
    
    var selectedGroupsArray: [GroupModel] = []
    
    lazy var addGroupButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
                
        button.addTarget(self, action: #selector(addTapped), for: .touchUpInside)        
        return button
    }()
    
    let cancelButtonImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage.init(named: "cancelIcon")
        view.isUserInteractionEnabled = true
        return view
    }()
    
    @objc func cancelButtonPressed() {
        searchBar.text = ""
        fetchData()
        selectedGroupsArray = groupsArray
        tableView.reloadData()
        searchBarHideAnimation()
    }
    
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()
    
    let lupaImageView = UIImageView(image: UIImage.init(named: "magnifyingGlass"))
    func setupSearchBar() {
        searchBar.barStyle = .default
        
        
        lupaImageView.clipsToBounds = true
        lupaImageView.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchTextField.addSubview(lupaImageView)
        lupaImageView.centerXAnchor.constraint(equalTo: searchBar.searchTextField.centerXAnchor).isActive = true
        lupaImageView.centerYAnchor.constraint(equalTo: searchBar.searchTextField.centerYAnchor).isActive = true
        lupaImageView.heightAnchor.constraint(equalTo: searchBar.searchTextField.heightAnchor, constant: -10).isActive = true
        lupaImageView.widthAnchor.constraint(equalTo: lupaImageView.heightAnchor).isActive = true

        searchBar.searchTextField.leftView = nil
        searchBar.sizeToFit()
        tableView.tableHeaderView = searchBar
        searchBar.delegate = self
        
        
        view.addSubview(cancelButtonImageView)
        cancelButtonImageView.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.width, width: 20, height: 20)
        cancelButtonImageView.isHidden = true
        
        let tapGestureRecognizer = UITapGestureRecognizer()
        tapGestureRecognizer.addTarget(self, action: #selector(cancelButtonPressed))
        cancelButtonImageView.addGestureRecognizer(tapGestureRecognizer)
        
        searchBar.searchTextField.clearButtonMode = .never
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        
        tableView.register(GroupsListTableViewCell.self, forCellReuseIdentifier: defaultCell)
        
        navigationController?.navigationBar.addSubview(addGroupButton)
        addGroupButton.rightAnchor.constraint(equalTo: (navigationController?.navigationBar.rightAnchor)!).isActive = true
        addGroupButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        addGroupButton.topAnchor.constraint(equalTo: (navigationController?.navigationBar.topAnchor)!).isActive = true
        addGroupButton.bottomAnchor.constraint(equalTo: (navigationController?.navigationBar.bottomAnchor)!).isActive = true
        
        setupSearchBar()
        
        vkAPIRequests()
    }
    
    @objc func addTapped() {
        if globalGroupsNamesArray.count == 0 {return}
        let globalGroupsTableViewController = GlobalGroupsTableViewController()
        globalGroupsTableViewController.title =  "Выбор группы"
        globalGroupsTableViewController.parentTableViewController = self
        globalGroupsTableViewController.transitioningDelegate = self
        navigationController?.pushViewController(globalGroupsTableViewController, animated: true)
    }
    
    func fetchData(){ // загрузка демо данных
        groupsArray = groupNamesArray.map
        {  GroupModel(
                groupName: $0,
                groupLogo: UIImage.init(named: "groupLogo_"+$0)!,//картинки из ассетс с названиями демо групп
                groupIsLiked: groupsLikesDictionary[$0] ?? false,
                groupLikesCount: groupsLikesCountDictionary[$0] ?? 0
            )
        }
        if selectedGroupsArray.count == 0 {selectedGroupsArray = groupsArray}
    }
    
    func vkAPIRequests(){
        VKAPIRequests.getUserGroups(userId: UserSession.shared.userId) //8. Получение групп текущего пользователя;
        VKAPIRequests.getGroupsByQuery(query: "Алиса") //9. Получение групп по поисковому запросу;
    }
    
    //MARK: АНИМАЦИИ начало
    func searchBarHideAnimation() {
        lupaBackAnimation(view: lupaImageView)
        searchTextFieldBackAnimation(view: searchBar.subviews[0])
        cancelButtonHideAnimation(view: cancelButtonImageView)
    }
    
    func searchBarShowAnimation() {
        lupaAnimation(view: lupaImageView)
        searchTextFieldAnimation(view: searchBar.subviews[0])
        cancelButtonShowAnimation(view: cancelButtonImageView)
    }
    
    
    private var startLupaPosition: CGFloat = 0
    func lupaAnimation(view: UIView) {
        let animation = CABasicAnimation(keyPath: "position.x")
        startLupaPosition = view.frame.origin.x
        animation.fromValue = startLupaPosition
        let newLupaPosition = searchBar.frame.maxX * 0.9 - view.frame.width
        animation.toValue = newLupaPosition
        view.frame.origin.x = newLupaPosition
        animation.duration = 0.5
        
        view.layer.add(animation, forKey: nil)
        
        view.translatesAutoresizingMaskIntoConstraints = true
        let rotation = CATransform3DMakeRotation(.pi, 0, 1, 0)
        let rotationAnimation = CABasicAnimation(keyPath: "transform")
        rotationAnimation.duration = 0.25
        rotationAnimation.autoreverses = true
        rotationAnimation.toValue = rotation
        
        view.layer.add(rotationAnimation, forKey: nil)
    }
    func lupaBackAnimation(view: UIView) {
        let animation = CABasicAnimation(keyPath: "position.x")
        animation.fromValue = view.frame.origin.x
        animation.toValue = startLupaPosition
        view.frame.origin.x = startLupaPosition
        
        animation.duration = 0.5
        view.layer.add(animation, forKey: nil)
        
        view.translatesAutoresizingMaskIntoConstraints = true
        let rotation = CATransform3DMakeRotation(.pi, 0, 1, 0)
        let rotationAnimation = CABasicAnimation(keyPath: "transform")
        rotationAnimation.duration = 0.25
        rotationAnimation.autoreverses = true
        rotationAnimation.toValue = rotation
        
        view.layer.add(rotationAnimation, forKey: nil)
    }
    
    func cancelButtonShowAnimation(view: UIView) {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 0.5
        view.layer.add(animation, forKey: nil)

        view.frame.origin.x = UIScreen.main.bounds.size.width - 40
        view.frame.origin.y = lupaImageView.frame.midY

        view.isHidden = false
    }
    func cancelButtonHideAnimation(view: UIView) {
        
        UIView.animate(withDuration: 0.5, animations: {
            let animation = CABasicAnimation(keyPath: "transform.scale")
            animation.toValue = 0
            view.layer.add(animation, forKey: nil)
        }, completion: { finished in
            view.isHidden = true
        })
        
    }
    
    enum SearchBarStatus {
        case waiting
        case editing
    }
    var searchBarStatus: SearchBarStatus = .waiting
    
    func searchTextFieldAnimation(view: UIView) {
        searchBarStatus = .editing
        UIView.animate(withDuration: 0.5, animations: ({
            view.transform = CGAffineTransform(scaleX: 0.9, y: 1).concatenating(CGAffineTransform(translationX: -view.frame.maxX*0.05, y: 0))
        }))
        cancelButtonShowAnimation(view: cancelButtonImageView)
    }
    
    func searchTextFieldBackAnimation(view: UIView) {
        UIView.animate(withDuration: 0.5, animations: ({
            view.transform = CGAffineTransform(scaleX: 1, y: 1)
        }))
        searchBar.resignFirstResponder()
        searchBarStatus = .waiting
        
    }
    //MARK: АНИМАЦИИ конец
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        addGroupButton.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        addGroupButton.isHidden = true
        if searchBarStatus == .editing {
            searchBarHideAnimation()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedGroupsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: defaultCell, for: indexPath) as! GroupsListTableViewCell
        cell.setup(group: selectedGroupsArray[indexPath.row])
        cell.likeTapped = { [weak self] in
            self?.selectedGroupsArray[indexPath.row].groupIsLiked.toggle()
            self?.selectedGroupsArray[indexPath.row].groupLikesCount += ((self?.selectedGroupsArray[indexPath.row].groupIsLiked)! ? 1:-1)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete { // изменяем демо данные при удалении группы из списка выбранных
                let removingGroupName = selectedGroupsArray[indexPath.row].groupName
                globalGroupsNamesArray.append(removingGroupName)
                groupNamesArray.remove(at: groupNamesArray.firstIndex(of: removingGroupName)!)
                selectedGroupsArray.remove(at: indexPath.row)
                fetchData()
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchBarStatus == .editing {
            searchBar.text = ""
            fetchData()
            selectedGroupsArray = groupsArray
            tableView.reloadData()
            searchBarHideAnimation()
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if searchBarStatus == .editing {
            searchBarHideAnimation()
        }
    }
    


}

extension GroupsTableViewController: UISearchBarDelegate {
   
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchText = searchBar.text
        fetchData()
        selectedGroupsArray = (searchText == "" ? groupsArray : groupsArray.filter{$0.groupName.contains(searchBar.text ?? "")})
        tableView.reloadData()
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if searchBarStatus == .waiting {
            searchBarShowAnimation()
        }
    }
    
}


extension GroupsTableViewController: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        return
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FromDownToTopAnimation()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FromDownToTopAnimation()
    }
    
    
}
