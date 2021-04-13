//
//  ViewController.swift
//  Lesson1_Homework_RachkovOleg
//
//  Created by Олег on 12.02.2021.
//

import UIKit

class LoginViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    let standardIndend: CGFloat = 20
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let loginTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "логин"
        textField.font? = UIFont.systemFont(ofSize: 16)
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "пароль"
        textField.font? = UIFont.systemFont(ofSize: 16)
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    

    let loginPasswordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10

        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("войти", for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)

        return button
    }()
    
    let containerScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    
    
    @objc func loginButtonPressed() {
        //ввели верный пароль
        if loginTextField.text == "" && passwordTextField.text == "" {
            let mainMenuTabBarViewController = MainMenuTabBarViewController()
            mainMenuTabBarViewController.transitioningDelegate = self
            navigationController?.pushViewController(mainMenuTabBarViewController, animated: true)
        } else {
            print("Логин или пароль неправильные")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        subViewsSetup(orientation: .portrait)
        
    }
    
    func viewSetup() {
        let gestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(tapAway))
        view.addGestureRecognizer(gestureRecogniser)
    }
    
    enum Orientation {
        case landscape
        case portrait
    }
    
    var logoViewTopConstraint = NSLayoutConstraint()
    var logoViewWidthConstraint = NSLayoutConstraint()
    var logoViewCenterXConstraint = NSLayoutConstraint()
    var logoViewHeightConstraint = NSLayoutConstraint()
    
    var loginPasswordViewCenterYConstraint = NSLayoutConstraint()
   
    var firstStart = true

    func subViewsSetup(orientation: Orientation) {
//        view.traitCollection.horizontalSizeClass - обработать ошибку, если приложение запускается сразу горизонтально
        
        if firstStart {
            view.addSubview(containerScrollView)
       
            containerScrollView.addSubview(logoImageView)
            
            let tapGestureRecognizer = UITapGestureRecognizer()
            tapGestureRecognizer.addTarget(self, action: #selector(logoTapped))
            logoImageView.addGestureRecognizer(tapGestureRecognizer)
            
            loginPasswordStackView.addArrangedSubview(loginTextField)
            loginPasswordStackView.addArrangedSubview(passwordTextField)
            loginPasswordStackView.addArrangedSubview(loginButton)
            loginPasswordStackView.addArrangedSubview(loadingIndicatorView)
            
            containerScrollView.addSubview(loginPasswordStackView)
            
            containerScrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            containerScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            containerScrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            containerScrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            
            containerScrollView.contentLayoutGuide.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            containerScrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            containerScrollView.contentLayoutGuide.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            containerScrollView.contentLayoutGuide.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            
            logoViewCenterXConstraint = NSLayoutConstraint(item: logoImageView, attribute: .centerX, relatedBy: .equal, toItem: containerScrollView.contentLayoutGuide, attribute: .centerX, multiplier: 1, constant: 0)
        }
        
        logoViewTopConstraint.isActive = false
        logoViewWidthConstraint.isActive = false
        logoViewCenterXConstraint.isActive = false
        if orientation == .portrait {
            logoViewTopConstraint = NSLayoutConstraint(item: logoImageView, attribute: .centerY, relatedBy: .equal, toItem: containerScrollView.contentLayoutGuide, attribute: .centerY, multiplier: 0.5, constant: 0)
            logoViewWidthConstraint = NSLayoutConstraint(item: logoImageView, attribute: .width, relatedBy: .equal, toItem: containerScrollView.contentLayoutGuide, attribute: .width, multiplier: 0.5, constant: 0)
        } else {
            logoViewTopConstraint = NSLayoutConstraint(item: logoImageView, attribute: .top, relatedBy: .equal, toItem: containerScrollView.contentLayoutGuide, attribute: .top, multiplier: 1, constant: standardIndend/4)
            logoViewWidthConstraint = NSLayoutConstraint(item: logoImageView, attribute: .width, relatedBy: .equal, toItem: containerScrollView, attribute: .width, multiplier: 0.25, constant: 0)
        }
        logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor).isActive = true
        logoViewTopConstraint.isActive = true
        logoViewWidthConstraint.isActive = true
        logoViewCenterXConstraint.isActive = true
        
        loginPasswordViewCenterYConstraint.isActive = false
        if orientation == .portrait {
        loginPasswordViewCenterYConstraint = NSLayoutConstraint(item: loginPasswordStackView, attribute: .top, relatedBy: .equal, toItem: logoImageView, attribute: .bottom, multiplier: 1, constant: standardIndend)
        } else {
            loginPasswordViewCenterYConstraint = NSLayoutConstraint(item: loginPasswordStackView, attribute: .bottom, relatedBy: .equal, toItem: containerScrollView.contentLayoutGuide, attribute: .bottom, multiplier: 1, constant: -standardIndend/2)
        }
        loginPasswordViewCenterYConstraint.isActive = true
        
        loginPasswordStackView.centerXAnchor.constraint(equalTo: containerScrollView.contentLayoutGuide.centerXAnchor).isActive = true
        loginPasswordStackView.widthAnchor.constraint(equalTo: containerScrollView.contentLayoutGuide.widthAnchor, multiplier: 0.75).isActive = true
        loginPasswordStackView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        
    }
    
    @objc func logoTapped() {
        let rotation = CATransform3DMakeRotation(.pi, 0, 1, 0)
        let animation = CABasicAnimation(keyPath: "transform")
        animation.duration = 0.5
        animation.toValue = rotation
        animation.autoreverses = true
        logoImageView.layer.add(animation, forKey: nil)
    }
    
    let loadingIndicatorView: LoadingIndicatorView = {
        let view = LoadingIndicatorView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    @objc func tapAway() {
        loginTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        let orientation = UIDevice.current.orientation
        if orientation == .landscapeLeft || orientation == .landscapeRight {
            subViewsSetup(orientation: .landscape)
        } else if orientation == .portrait || orientation == .portraitUpsideDown {
            subViewsSetup(orientation: .portrait)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //подписываемся на уведомления о появлении и исчезновении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        loadingIndicatorView.startLoadingAnimation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWasShown(notification: Notification) { //Когда клавиатура появляется
        let info = notification.userInfo! as NSDictionary
        let keyBoardSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyBoardSize.height, right: 0.0)
        
        containerScrollView.contentInset = contentInsets
        containerScrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillBeHidden() {//Когда клавиатура исчезает
        let contentInsets = UIEdgeInsets.zero
        containerScrollView.contentInset = contentInsets
    }
    
    
}
