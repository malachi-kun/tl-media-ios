//
//  HomeModalController.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2017/12/14.
//  Copyright © 2017 Tabi-Labo. All rights reserved.
//
// The secondary viewController of the primary Container View Controller.

import UIKit

class HomeModalController:UIViewController {

    // MARK: UI COMPONENTS
    let topControllerView:UIView = {
        let topView = UIView()
        topView.backgroundColor = .white
        return topView
    }()
    
    let articleImageView:UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "TL")
        return iv
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.text = "Article Title \nsecond line"
        label.font = UIFont.systemFont(ofSize: 17)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        //label.backgroundColor = .green
        return label
    }()
    
    let issueLabel:UILabel = {
        let label = UILabel()
        label.text = "ISSUE 2017/12/18"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let playPauseButton:UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        return button
    }()
    
    //BLOCKS SENDER AND MESSAGEBOX
    let blockSendButton:UIView = {
        let ui = UIView()
        ui.backgroundColor = .black
        return ui
    }()
    

    // MARK: OUTLETS
    @IBOutlet weak var audioChat: UIView!
    
    // MARK: LIFECYLE
    override func viewDidLoad() {
       setupView()
    }

    // MARK: ASSIST METHODS
    private func setupView(){
        view.backgroundColor = .black
        audioChat.backgroundColor = .black
        
        //**top audio control**
        view.addSubview(topControllerView)
        topControllerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop:35, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 85)
        
        //article image
        topControllerView.addSubview(articleImageView)
        let topBottomPadding:CGFloat = 15
        articleImageView.anchor(top: topControllerView.topAnchor, left: topControllerView.leftAnchor, bottom: topControllerView.bottomAnchor, right: nil, paddingTop: topBottomPadding, paddingLeft: 0, paddingBottom: -topBottomPadding, paddingRight: 0, width: 50, height: 50)
        
        //title label
        topControllerView.addSubview(titleLabel)
        let leftPadding:CGFloat = 15
        let labelWidth:CGFloat = 250
        titleLabel.anchor(top: topControllerView.topAnchor, left: articleImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: leftPadding, paddingBottom:0, paddingRight: 0, width: labelWidth, height: 45)
        
        //issue label
        topControllerView.addSubview(issueLabel)
        issueLabel.anchor(top: titleLabel.bottomAnchor, left: articleImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: leftPadding, paddingBottom:0, paddingRight: 0, width: labelWidth, height: 15)
        
        //play~pause button
        topControllerView.addSubview(playPauseButton)
        playPauseButton.anchor(top: topControllerView.topAnchor, left: nil, bottom: topControllerView.bottomAnchor, right: topControllerView.rightAnchor, paddingTop: topBottomPadding, paddingLeft: 0, paddingBottom: -topBottomPadding, paddingRight: -50, width: 150, height:150)
        //**top audio control**
        
        //**Chat message display**
        view.addSubview(audioChat)
        audioChat.anchor(top: topControllerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 550)
        
        audioChat.addSubview(blockSendButton)
        blockSendButton.anchor(top: nil, left: audioChat.leftAnchor, bottom: audioChat.bottomAnchor, right: audioChat.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: audioChat.frame.width, height: 50)
    }
}
