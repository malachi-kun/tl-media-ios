//
//  HeadlineArticleView.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2018/02/01.
//  Copyright © 2018 Tabi-Labo. All rights reserved.
//

import UIKit

class HeadlineArticeView:UIView {
    
    // MARK: UI COMPONENTS
    let articleImage:UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "TL")
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .clear
        iv.layer.cornerRadius = 8.0
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    //multiple line title
    let titleBackgroundLabel:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.backgroundColor = .white
        //label.layer.cornerRadius = 8.0
        label.text = ""
        label.layer.masksToBounds = true
        return label
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.backgroundColor = .clear
        label.layer.cornerRadius = 8.0
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = "no text found"
        return label
    }()
    
    let categoryLabel:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.backgroundColor = .white
        label.layer.cornerRadius = 8.0
        label.text = " Entertainment "
        return label
    }()
    
    let newImage:UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "newIcon")
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .clear
        iv.clipsToBounds = true
        return iv
    }()
    
    let authorImage:UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "TL")
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .clear
        iv.layer.cornerRadius = iv.frame.height/2
        iv.clipsToBounds = true
        return iv
    }()
    
    let authorLabel:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.backgroundColor = .clear
        label.layer.cornerRadius = 8.0
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = " [authorName] "
        return label
    }()
    
    let issueDateLabel:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.backgroundColor = .clear
        label.layer.cornerRadius = 8.0
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = " 99/99/99 "
        return label
    }()
    
    let redPlayIcon:UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "redPlay"), for: .normal)
        button.isUserInteractionEnabled = true
        return button
    }()
    
    // MARK: LIFECYCLE
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ASSIST METHODS
    private func setupView(){
        backgroundColor = .clear

        //Bottom text bar content
        addSubview(titleBackgroundLabel)
        titleBackgroundLabel.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: bounds.width, height: 60)

        addSubview(articleImage)
        articleImage.anchor(top: topAnchor, left: leftAnchor, bottom: titleBackgroundLabel.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 5, paddingRight: 0, width: 0, height: 0)
        
        titleBackgroundLabel.addSubview(titleLabel)
        titleLabel.anchor(top: titleBackgroundLabel.topAnchor, left: leftAnchor, bottom: titleBackgroundLabel.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        titleBackgroundLabel.addSubview(authorLabel)
        authorLabel.anchor(top: titleBackgroundLabel.topAnchor, left: nil, bottom: titleBackgroundLabel.bottomAnchor, right: titleBackgroundLabel.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        titleBackgroundLabel.addSubview(authorImage)
        authorImage.anchor(top: nil, left: nil, bottom: authorLabel.bottomAnchor, right: authorLabel.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: -17, paddingRight: 5, width: 25, height: 25)
     
        //Elements around image and text
        addSubview(categoryLabel)
        categoryLabel.anchor(top: nil, left: leftAnchor, bottom: titleBackgroundLabel.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 5, paddingRight: 0, width: bounds.width, height: 15)
        
        addSubview(newImage)
        newImage.anchor(top: nil, left: categoryLabel.rightAnchor, bottom: titleBackgroundLabel.topAnchor, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 5, paddingRight: 0, width: 0, height: 0)
        
        addSubview(redPlayIcon)
        redPlayIcon.anchor(top: nil, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: -43, paddingRight: 12, width: 0, height: 0)
        
        //View orientation
        bringSubview(toFront: articleImage)
        bringSubview(toFront: titleBackgroundLabel)
        bringSubview(toFront: categoryLabel)
        bringSubview(toFront: newImage)
        bringSubview(toFront: redPlayIcon)
    }
}
