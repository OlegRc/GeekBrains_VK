//
//  ImageLoader.swift
//  Lesson8_Homework_RachkovOleg
//
//  Created by Олег Рачков on 11.04.2021.
//

import UIKit

let imageCache = NSCache<AnyObject, UIImage>()

class ImageLoader: UIImageView {
    
    var imageURL: URL?
    
    lazy var activityIndicator: UIActivityIndicatorView? = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = .darkGray
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        return activityIndicator
    }()
    
    var emptyImage: UIImage? = UIImage.init(named: "photoPlaceholder")
    
    var transformImage: ((UIImage) -> (UIImage)) = { $0 }
    
    func loadImageWithUrl(_ url: URL) {
        imageURL = url
        
        image = nil
        activityIndicator?.startAnimating()
        if (setImageFromCache(withURL: url) == true) {
            return
        }
        
        cacheAndSetImage(fromURL: url)
    }
    
    func setImageFromCache(withURL url: URL) -> Bool {
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) {
            self.image = imageFromCache
            activityIndicator?.stopAnimating()
            return true
        }
        return false
    }
    
    func cacheAndSetImage(fromURL url: URL) {
        URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
            if error != nil {
                print(error as Any)
                return
            }
            
            DispatchQueue.main.async(execute: {
                if let unwrappedData = data, let imageToCache = UIImage(data: unwrappedData) {
                    guard let transformedImage = self?.transformImage(imageToCache) else {
                        return
                    }
                    
                    if self?.imageURL == url {
                        self?.image = transformedImage
                    }
                    
                    imageCache.setObject(transformedImage, forKey: url as AnyObject)
                }
                self?.activityIndicator?.stopAnimating()
            })
        }).resume()
    }
}

