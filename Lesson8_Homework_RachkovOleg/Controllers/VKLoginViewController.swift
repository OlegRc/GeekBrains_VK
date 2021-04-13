//
//  VKLoginViewController.swift
//  Lesson8_Homework_RachkovOleg
//
//  Created by Олег Рачков on 21.03.2021.
//

import UIKit
import WebKit

class VKLoginViewController: UIViewController, WKUIDelegate, WKNavigationDelegate, UIViewControllerTransitioningDelegate {
    private let networkSession = NetworkService()
    
    let authorisationWebView: WKWebView = {
        let view = WKWebView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WKWebView.clean()
        authorisationWebView.navigationDelegate = self
        
        view.addSubview(authorisationWebView)

        authorisationWebView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        authorisationWebView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        authorisationWebView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        authorisationWebView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard navigationResponse.response.url?.path == "/blank.html",
              let fragment = navigationResponse.response.url?.fragment else {
            decisionHandler(.allow)
            return
        }
        
        let parameters = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=")}
            .reduce([String: String]()) { result, parameter in
                var dictionary = result
                let key = parameter[0]
                let value = parameter[1]
                dictionary[key] = value
                return dictionary
            }
        
        //3. Сохранить токен в синглтоне Session;
        UserSession.shared.token = parameters["access_token"]!
        UserSession.shared.userId = parameters["user_id"]!
        
        authorisationSuccess()
        
        decisionHandler(.allow)
    }
    
    func authorisationSuccess() {
            let mainMenuTabBarViewController = MainMenuTabBarViewController()
            mainMenuTabBarViewController.transitioningDelegate = self
            navigationController?.pushViewController(mainMenuTabBarViewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        authorisationWebView.load(networkSession.prepareVKAuthRequest())
    }

}

extension WKWebView {
    class func clean() {
        return
        guard #available(iOS 9.0, *) else {return}

        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)

        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
    }
}

