//
//  BuyController.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2018/01/04.
//  Copyright © 2018 Tabi-Labo. All rights reserved.
//

import UIKit

class BuyController:UIViewController {
    
    // MARK: UI COMPONENTS
    lazy var dismissImageView:UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "DismissX")
        iv.contentMode = .scaleAspectFit
        iv.isUserInteractionEnabled = true  //makes it clickable or interactable.
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(screenDismiss)))
        return iv
    }()
    
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
    
    let continueButton:UIButton = {
        let button = UIButton()
        button.setTitle("CONTINUE", for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(presentLogin), for: .touchUpInside)
        return button
    }()
    
    let buyButtonImageView:UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "BuyIcon")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let descriptionLabel: UILabel =  {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "Buy Buy Buy\n", attributes: [NSAttributedStringKey.foregroundColor:UIColor.white, NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: "Like a product! \nBuy it here!", attributes: [NSAttributedStringKey.foregroundColor:UIColor.white, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 10)]))
        
        label.attributedText = attributedText
        
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    
    // MARK: LIFECYCLE
    override func viewDidLoad() {
        //init
        setupUI()
    }
    
    // MARK: ACTION
    @objc func presentLogin(){
        let loginVC = LoginController()
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @objc func screenDismiss(){
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: ASSIST METHODS
    private func setupUI(){
        view.backgroundColor = .black
        centerTabiLaboIcon()
        
        view.addSubview(dismissImageView)
        dismissImageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 50, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(enjoyTabiLaboImageView)
        enjoyTabiLaboImageView.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 70, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 156, height: 88)
        enjoyTabiLaboImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(continueButton)
        continueButton.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: -100, paddingRight: 0, width: 288, height: 50)
        continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        //common bottom padding
        let bottomPadding:CGFloat = -40
        //play button
        view.addSubview(buyButtonImageView)
        buyButtonImageView.anchor(top: nil, left: continueButton.leftAnchor, bottom: continueButton.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: bottomPadding, paddingRight: 0, width: 49, height: 49)
        
        //description label
        view.addSubview(descriptionLabel)
        descriptionLabel.anchor(top: nil, left: buyButtonImageView.rightAnchor, bottom: continueButton.topAnchor, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: bottomPadding, paddingRight: 0, width: 0, height: 0)
    }
    
    private func centerTabiLaboIcon(){
        //Tabi Labo Icon in the center
        view.addSubview(logoImageView)
        logoImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
