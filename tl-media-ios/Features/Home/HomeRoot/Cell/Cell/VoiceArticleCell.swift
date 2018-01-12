//
//  HomeScrollCell.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2017/12/04.
//  Copyright © 2017 Tabi-Labo. All rights reserved.
//

import UIKit


class VoiceArticleCell:UICollectionViewCell {
    // MARK: UI ELEMENTS
    let imageView:UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "TL")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let topLayer:UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        v.backgroundColor = .black
        v.layer.opacity = 0.25
        return v
    }()
    
    var titleLabel:UILabel = {
       var label = UILabel()
        label.text = "This is a title."
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    var issueLabel:UILabel = {
        let label = UILabel()
        label.text = "ISSUE"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    
    var dateLabel:UILabel = {
        let label = UILabel()
        label.text = "2018/11/01"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let playButton:UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "play"), for: .normal)
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
    
    // MARK: UI
    private func setupView(){
        addSubview(imageView)
        addSubview(topLayer)
        //bringSubview(toFront: topLayer)
        addSubview(titleLabel)
        addSubview(issueLabel)
        addSubview(dateLabel)

        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        topLayer.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        titleLabel.anchor(top: nil, left: leftAnchor, bottom: issueLabel.topAnchor, right: rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: -5, paddingRight: 100, width: 0, height: 0)
        
        issueLabel.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 10, paddingLeft: 15, paddingBottom: -10, paddingRight: 0, width: 0, height: 0)
        
        dateLabel.anchor(top: titleLabel.bottomAnchor, left: issueLabel.rightAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 15, paddingBottom: -10, paddingRight: 0, width: 0, height: 0)
        
        addSubview(playButton)
        playButton.anchor(top: nil, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: -20, paddingRight: 20, width: 38, height: 38)
    }
}
