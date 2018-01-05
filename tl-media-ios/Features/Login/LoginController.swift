//
//  LoginController.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2018/01/04.
//  Copyright © 2018 Tabi-Labo. All rights reserved.
//

import UIKit

class LoginController:UIViewController {
    
    // MARK: UI COMPONENTS
    let logoImageView:UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "LOGO")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let enjoyTabiLaboImageView:UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "HowToEnjoyTabiLabo")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let signInButton:UIButton = {
        let button = UIButton()
        button.setTitle("Sign in", for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let signUpButton:UIButton = {
        let button = UIButton()
        button.setTitle("sign up here", for: .normal)
        return button
    }()
    
    let forgotPasswordButton:UIButton = {
        let button = UIButton()
        button.setTitle("forget password", for: .normal)
        return button
    }()
    
    let emailTxtField:UITextField = {
        let textfield = UITextField()
        //textfield.placeholder = "email"
        textfield.backgroundColor = .gray
        textfield.attributedPlaceholder = NSAttributedString(string: "email",
                                                             attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        return textfield
    }()
    
    let passwordTxtField:UITextField = {
        let textfield = UITextField()
        //textfield.placeholder = "password"
        textfield.attributedPlaceholder = NSAttributedString(string: "password",
                                                             attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        textfield.backgroundColor = .gray
        textfield.isSecureTextEntry = true
        
//        let border = CALayer()
//        let width = CGFloat(2.0)
//        border.borderColor = UIColor.darkGray.cgColor
//        border.frame = CGRect(x: 0, y: textfield.frame.size.height - width, width:  textfield.frame.size.width, height: textfield.frame.size.height)
//
//        border.borderWidth = width
//        textfield.layer.addSublayer(border)
//        textfield.layer.masksToBounds = true
        
        return textfield
    }()

    // MARK: LIFECYCLE
    override func viewDidLoad() {
        //init
        setupUI()
    }
    
    // MARK: ACTION
    @objc func screenDismiss(){
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: ASSIST METHODS
    private func setupUI(){
        view.backgroundColor = UIColor(displayP3Red: 31/255, green: 31/255, blue: 31/255, alpha: 1.0)

        view.addSubview(logoImageView)
        logoImageView.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 140, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 24)
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        setUpSignUpStackView()
        loginSetupLoginTextField()
    }
    
    private func setUpSignUpStackView(){
        let stackView = UIStackView(arrangedSubviews: [signUpButton, forgotPasswordButton])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 25

        view.addSubview(stackView)
        stackView.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: -250, paddingRight: 0, width: 207, height: 30)
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(signInButton)
        signInButton.anchor(top: nil, left: nil, bottom: stackView.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: -20, paddingRight: 0, width: 207, height: 45)
        signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func loginSetupLoginTextField(){
        let stackView = UIStackView(arrangedSubviews: [emailTxtField, passwordTxtField])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 35
        
        view.addSubview(stackView)
        stackView.anchor(top: nil, left: nil, bottom: signInButton.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: -125, paddingRight: 0, width: 210, height: 100)
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
