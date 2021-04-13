//
//  CollectionViewController.swift
//  Lesson1_Homework_RachkovOleg
//
//  Created by Олег Рачков on 21.02.2021.
//

import UIKit

class FriendsPhotoCollectionViewController: UICollectionViewController, UIViewControllerTransitioningDelegate {

    let defaultCell = "defaultCell"
    
    var userPhotosUrlArray: [String] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.isScrollEnabled = true
        collectionView.register(FriendsPhotoCollectionViewCell.self, forCellWithReuseIdentifier: defaultCell)
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadUsersPhotos(_:)), name: .usersPhotosRecieved, object: nil)//оповещение о завершении загрузки данных со списком друзей
    }
    
    @objc func loadUsersPhotos(_ notification: NSNotification) {
        guard let photosArray = notification.userInfo?["userPhotosUrlArray"] as? [String] else {return}
        
        userPhotosUrlArray = photosArray
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userPhotosUrlArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: defaultCell, for: indexPath) as! FriendsPhotoCollectionViewCell
        
        cell.setup(photoUrl: userPhotosUrlArray[indexPath.row])
        return cell
    }
    

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let friendZoomedPhotoViewController = FriendsZoomedPhotoViewController()
        friendZoomedPhotoViewController.currentPhotoIndex = indexPath.row
        friendZoomedPhotoViewController.transitioningDelegate = self
        friendZoomedPhotoViewController.userPhotosUrlArray = userPhotosUrlArray
        if let recognizers = navigationController?.view.gestureRecognizers {
            for recognizer in recognizers {
                recognizer.isEnabled = false
            }
        }
        
        navigationController?.pushViewController(friendZoomedPhotoViewController, animated: true)
    }
 
}

extension FriendsPhotoCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = UIScreen.main.bounds.size.width / 2 - 10
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
    }
    
}

