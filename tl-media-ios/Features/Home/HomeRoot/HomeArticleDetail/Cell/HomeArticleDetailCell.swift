//
//  HomeArticleDetailCell.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2018/01/10.
//  Copyright © 2018 Tabi-Labo. All rights reserved.
//

import UIKit

class HomeArticleDetailCell:UICollectionViewCell {
    
    // MARK: UI COMPONENETS
    //**Top section
    let articleHeaderImage:UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "blackBackGround")
        iv.contentMode = .scaleAspectFit
        iv.isUserInteractionEnabled = false
        return iv
    }()
    
    let exitButton:UIButton = {
        let button = UIButton()
        //button.setTitle("X", for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "exitIcon"), for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.isUserInteractionEnabled = true
        return button
    }()
    
    let playButton:UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "playTrack"), for: .normal)
        button.isUserInteractionEnabled = true
        return button
    }() 
    
    //article header
    let titleLabel:UILabel = {
        let label = UILabel()
        label.text = "I bomb atomically.  Socrates, philosphy, and high prophecies can't defining why I be dropping these mockery."
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let profileImage:UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "TL")
        iv.backgroundColor = .white
        iv.layer.cornerRadius = iv.frame.size.width/2
        iv.clipsToBounds = true
        return iv
    }()
    
    let authorNameLabel:UILabel = {
        let label = UILabel()
        label.text = "Person name"
        return label
    }()
    
    let issueDateLabel:UILabel = {
        let label = UILabel()
        label.text = "ISSUE"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    let dateLabel:UILabel = {
        let label = UILabel()
        label.text = "2018/01/10"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    //body
    let bodyLabel:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.sizeToFit()
        label.text = ""
        return label
    }()
    

    // MARK: LIFECYCLE
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: ASSIST METHODS
    func setUpUI(){
        addSubview(articleHeaderImage)
        articleHeaderImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: -50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 220)
        
        addSubview(exitButton)
        exitButton.anchor(top: articleHeaderImage.topAnchor, left: nil, bottom: nil, right: articleHeaderImage.rightAnchor, paddingTop: 60, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        
        addSubview(playButton)
        playButton.anchor(top: nil, left: nil, bottom: articleHeaderImage.bottomAnchor, right: articleHeaderImage.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: -10, paddingRight: 15, width: 50, height: 50)
        
        addSubview(titleLabel)
        titleLabel.anchor(top: articleHeaderImage.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: -10, width: 0, height: 0)
        
        addSubview(profileImage)
        let topPad:CGFloat = 10, leftPad:CGFloat = 10
        profileImage.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: topPad, paddingLeft: leftPad, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        
        addSubview(authorNameLabel)
        authorNameLabel.anchor(top: titleLabel.bottomAnchor, left: profileImage.rightAnchor, bottom: nil, right: nil, paddingTop: topPad, paddingLeft: leftPad, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(issueDateLabel)
        let rightPad:CGFloat = 125
        issueDateLabel.anchor(top: titleLabel.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: topPad, paddingLeft: 0, paddingBottom: 0, paddingRight: rightPad, width: 0, height: 0)
        
        addSubview(dateLabel)
        dateLabel.anchor(top: titleLabel.bottomAnchor, left: issueDateLabel.rightAnchor, bottom: nil
            , right: rightAnchor, paddingTop: topPad, paddingLeft: leftPad, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(bodyLabel)
        bodyLabel.anchor(top: profileImage.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: topPad, paddingLeft: leftPad, paddingBottom: 10, paddingRight: 10, width: UIScreen.main.bounds.size.width-(2*12), height: 0)
    }
}
