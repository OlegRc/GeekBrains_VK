//
//  AKAPIRequests.swift
//  Lesson8_Homework_RachkovOleg
//
//  Created by Олег Рачков on 27.03.2021.
//

import UIKit

class VKAPIRequests {

    convenience required init(from decoder: Decoder) throws {
        self.init()
    }
    
    static var token = UserSession.shared.token
    
    static let vkAPIVersion = "5.92"
        
    class func getUserFriends (userId: String) {

        struct FriendsPreview: Codable {
            let response: Response
            
            struct Response: Codable {
                let count: Int
                let items: [Item]
                
                struct Item: Codable {
                    let first_name: String
                    let id: Int
                    let last_name: String
                    let deactivated: String?
                    let can_access_closed: Bool?
                    let is_closed: Bool?
                    let lists: [Int]?
                    let track_code: String
                    let photo_400: String?
                }
            }
        }
        
        var urlComponents = URLComponents()
                urlComponents.scheme = "https"
                urlComponents.host = "api.vk.com"
                urlComponents.path = "/method/friends.get"
                urlComponents.queryItems = [
                    URLQueryItem(name: "access_token", value: token),
                    URLQueryItem(name: "v", value: vkAPIVersion),
                    URLQueryItem(name: "fields", value: "name,photo_400"),
                ]

                
        let request = URLRequest(url: urlComponents.url!)
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                
                do {
                    let friends = try JSONDecoder().decode(FriendsPreview.self, from: data) as FriendsPreview
                    let friendsArray = friends.response.items.map
                    {  FriendModel(
                            id: $0.id,
                            name: $0.first_name + " " + $0.last_name,
                            avatarImageUrlString: $0.photo_400 ?? ""
                        )
                    }
                    NotificationCenter.default.post(name: .friendsListRecieved, object: self, userInfo: ["friendsArray": friendsArray])//отправляем оповещение о завершении загрузки списка пользователей
                } catch let jSonErr {
                    print(jSonErr)
                }
                
            } else if  let error = error {
                print(error)
            }
        }
        dataTask.resume()

    }
    
    
    class func getUserPhoto (userId: String) { //7. Получение фотографий человека;
        
        struct UserPhotosPreview: Codable {
            let response: Response
            
            struct Response: Codable {
                let count: Int
                let items: [Item]
                
                struct Item: Codable {
                    let id: Int
                    let album_id: Int
                    let date: Int
                    let owner_id: Int
                    let has_tags: Bool
                    
                    let sizes: [Size]
                    struct Size: Codable {
                        let height: Int
                        let url: String
                        let type: String
                        let width: Int
                    }
                    
                    let likes: Likes?
                    struct Likes: Codable {
                        let user_likes: Int
                        let count: Int
                    }
                    
                    let reposts: Reposts?
                    struct Reposts: Codable {
                        let user_likes: Int
                        let count: Int
                    }
                    
                    let real_offset: Int?
                    let post_id: Int?
                }
                
                let more: Int?
            }
        }
        
        let photosCountLimit: Int = 20
        
        var urlComponents = URLComponents()
                urlComponents.scheme = "https"
                urlComponents.host = "api.vk.com"
                urlComponents.path = "/method/photos.getAll"
                urlComponents.queryItems = [
                    URLQueryItem(name: "access_token", value: token),
                    URLQueryItem(name: "v", value: vkAPIVersion),
                    URLQueryItem(name: "owner_id", value: userId),
                    URLQueryItem(name: "count", value: String(photosCountLimit))
                ]
        
        let request = URLRequest(url: urlComponents.url!)

        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let userPhotos = try JSONDecoder().decode(UserPhotosPreview.self, from: data) as UserPhotosPreview
                    
                    var userPhotosUrlArray: [String] = []
                    
                    userPhotos.response.items.forEach { item in
                        for size in item.sizes {
                            if size.height > 200 {
                                userPhotosUrlArray.append(size.url)
                                return
                            }
                        }
                    }
                    NotificationCenter.default.post(name: .usersPhotosRecieved, object: self, userInfo: ["userPhotosUrlArray": userPhotosUrlArray]) //отправляем оповещение о завершении загрузки списка фотографий пользователя
                } catch let error {
                    print(error)
                }
               
            
                
//                let friendsArray = friends.response.items.map
//                {  FriendModel(
//                        id: Double($0.id),
//                        name: $0.first_name + " " + $0.last_name,
//                        avatarImageUrlString: $0.photo_400 ?? ""
//                    )
//                }
            } else if  let error = error {
                print(error)
            }
        }

        dataTask.resume()
        
        print(UserSession.shared.token)
    }
    
    class func getUserGroups (userId: String) { //8. Получение групп текущего пользователя;
        
        var urlComponents = URLComponents()
                urlComponents.scheme = "https"
                urlComponents.host = "api.vk.com"
                urlComponents.path = "/method/groups.get"
                urlComponents.queryItems = [
                    URLQueryItem(name: "access_token", value: token),
                    URLQueryItem(name: "v", value: vkAPIVersion),
                    URLQueryItem(name: "user_id", value: userId)
                ]
        
        let request = URLRequest(url: urlComponents.url!)

        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let jsonText = try? JSONSerialization.jsonObject(with: data)
                print(jsonText as Any)
            } else if  let error = error {
                print(error)
            }
        }

        dataTask.resume()
        
    }

    class func getGroupsByQuery (query: String) { //9. Получение групп по поисковому запросу;
        
        var urlComponents = URLComponents()
                urlComponents.scheme = "https"
                urlComponents.host = "api.vk.com"
                urlComponents.path = "/method/groups.search"
                urlComponents.queryItems = [
                    URLQueryItem(name: "access_token", value: token),
                    URLQueryItem(name: "v", value: vkAPIVersion),
                    URLQueryItem(name: "q", value: query)
                ]
        
        let request = URLRequest(url: urlComponents.url!)

        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let jsonText = try? JSONSerialization.jsonObject(with: data)
                print(jsonText as Any)
            } else if  let error = error {
                print(error)
            }
        }

        dataTask.resume()
        
        print(UserSession.shared.token)
    }
    
}
