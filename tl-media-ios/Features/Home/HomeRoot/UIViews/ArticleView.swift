//
//  Article.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2018/02/14.
//  Copyright © 2018 Tabi-Labo. All rights reserved.
//

import UIKit

class ArticleView:UIView{
    //UI COMPONENTS
    
    //article image
    let articleImage:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8.0
        iv.isUserInteractionEnabled = true
        return iv
    }()

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
        label.font = UIFont.boldSystemFont(ofSize: 10)
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
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.backgroundColor = .white
        label.layer.cornerRadius = 8.0
        label.text = " Entertainment "
        return label
    }()

    let newImage:UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "newIcon")
        iv.isHidden = true
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
        label.font = UIFont.systemFont(ofSize: 8)
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
        label.font = UIFont.systemFont(ofSize: 10)
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
        
        addSubview(articleImage)
        articleImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)

        addSubview(titleBackgroundLabel)
        titleBackgroundLabel.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 80)
        
        addSubview(categoryLabel)
        categoryLabel.anchor(top: nil, left: leftAnchor, bottom: titleBackgroundLabel.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 0)
        
        addSubview(newImage)
        newImage.anchor(top: nil, left: categoryLabel.rightAnchor, bottom: titleBackgroundLabel.topAnchor, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 10, paddingRight: 0, width: 0, height: 0)
        
        addSubview(titleLabel)
        titleLabel.anchor(top: categoryLabel.bottomAnchor, left: leftAnchor, bottom: titleBackgroundLabel.bottomAnchor, right: rightAnchor, paddingTop: -30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(authorImage)
        authorImage.anchor(top: nil, left: leftAnchor, bottom: titleBackgroundLabel.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 25, height: 25)
        
        addSubview(authorLabel)
        authorLabel.anchor(top: authorImage.topAnchor, left: authorImage.rightAnchor, bottom: authorImage.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(issueDateLabel)
        issueDateLabel.anchor(top: authorImage.topAnchor, left: nil, bottom: authorImage.bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(redPlayIcon)
        redPlayIcon.anchor(top: nil, left: nil, bottom: titleBackgroundLabel.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 12, paddingRight: 5, width: 25, height: 25)
    
    }
}
