//
//  NetworkService.swift
//  Lesson8_Homework_RachkovOleg
//
//  Created by Олег Рачков on 21.03.2021.
//

import UIKit

class NetworkService {

    func prepareVKAuthRequest() -> URLRequest {
        var urlComponents = URLComponents()
                urlComponents.scheme = "https"
                urlComponents.host = "oauth.vk.com"
                urlComponents.path = "/authorize"
                urlComponents.queryItems = [
                    URLQueryItem(name: "client_id", value: "7797763"),
                    URLQueryItem(name: "display", value: "mobile"),
                    URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
                    URLQueryItem(name: "scope", value: "262150"),
                    URLQueryItem(name: "response_type", value: "token"),
                    URLQueryItem(name: "v", value: "5.130")
                ]

        let request = URLRequest(url: urlComponents.url!)
        
        return request


    }
    
}

