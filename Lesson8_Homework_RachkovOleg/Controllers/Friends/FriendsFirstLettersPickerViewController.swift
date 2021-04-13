//
//  FriendsFirstLettersPickerViewController.swift
//  Lesson1_Homework_RachkovOleg
//
//  Created by Олег Рачков on 07.03.2021.
//

import UIKit

class FriendsFirstLettersPickerViewController: UIViewController {
    var pickerViewStrings: [String] = []
    var parentTableView: FriendsListTableViewController?
    
    private var selectedIndex: Int = 0
    
    lazy var pickerView: UIPickerView = {
        let view = UIPickerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 50
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
        
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        view.addSubview(containerView)
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -16).isActive = true
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 45).isActive = true
        
        containerView.addSubview(pickerView)
        pickerView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        pickerView.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
     
    }
    
    @objc private func handleTap() {
        dismiss(animated: true, completion: nil)
    }
}

extension FriendsFirstLettersPickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        (parentTableView?.sectionedFriends.count)! + 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerViewStrings[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedLetter = pickerViewStrings[row]
        
        let selectedSectionedFriends = ( selectedLetter == "<все>" ? parentTableView?.sectionedFriends : parentTableView?.sectionedFriends.filter({String($0.title) == selectedLetter}) )

        parentTableView?.selectedSectionedFriends = selectedSectionedFriends ?? []

        parentTableView?.tableView.reloadData()
    }
    
}
