//
//  LoginController.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2018/01/04.
//  Copyright © 2018 Tabi-Labo. All rights reserved.
//

import UIKit

class ListenController:UIViewController {
    
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
    
    let continueButton:UIButton = {
        let button = UIButton()
        button.setTitle("CONTINUE", for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(presentDownload), for: .touchUpInside)
        return button
    }()
    
    let playButtonImageView:UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "Playbutton")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let descriptionLabel: UILabel =  {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "Listen to articles\n", attributes: [NSAttributedStringKey.foregroundColor:UIColor.white, NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: "Better than reading articles! \nYou can listen with your two ears.", attributes: [NSAttributedStringKey.foregroundColor:UIColor.white, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 10)]))
        
        label.attributedText = attributedText
        
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    
    // MARK: LIFECYCLE
    override func viewDidLoad() {
         setupUI()
    }
    
    // MARK: ACTION
    @objc func presentDownload(){
        let downloadVC = DownloadController()
        self.navigationController?.pushViewController(downloadVC, animated: true)
       
    }
    
    // MARK: ASSIST METHODS
    private func setupUI(){
        view.backgroundColor = UIColor(displayP3Red: 31/255, green: 31/255, blue: 31/255, alpha: 1.0)
        view.addSubview(continueButton)
    
        centerTabiLaboIcon()
        
        view.addSubview(enjoyTabiLaboImageView)
        enjoyTabiLaboImageView.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 70, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 156, height: 88)
        enjoyTabiLaboImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        continueButton.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: -100, paddingRight: 0, width: 288, height: 50)
        continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        //common bottom padding
        let bottomPadding:CGFloat = -40
        //play button
        view.addSubview(playButtonImageView)
        playButtonImageView.anchor(top: nil, left: continueButton.leftAnchor, bottom: continueButton.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: bottomPadding, paddingRight: 0, width: 49, height: 49)
        
        //description label
        view.addSubview(descriptionLabel)
        descriptionLabel.anchor(top: nil, left: playButtonImageView.rightAnchor, bottom: continueButton.topAnchor, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: bottomPadding, paddingRight: 0, width: 0, height: 0)
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
