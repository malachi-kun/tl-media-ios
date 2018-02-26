//
//  AudioToolBar.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2017/12/19.
//  Copyright © 2017 Tabi-Labo. All rights reserved.
//

import UIKit

class AudioToolBar:UIView{
    
    let articleImageView:UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "TL")
        return iv
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "This is the title description."
//        label.lineBreakMode = .byWordWrapping
//        label.numberOfLines = 0
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
    
    let playBtn:UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Playbutton"), for: .normal)
        button.isUserInteractionEnabled = true
        return button
    }()
    
    let backTrackBtn:UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "backwardTrack"), for: .normal)
        button.isUserInteractionEnabled = true
        return button
    }()
    
    let forwardTrackBtn:UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "forwardTrack"), for: .normal)
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
    
    private func setupView(){
        //article image
        addSubview(articleImageView)
        let topBottomPadding:CGFloat = 15
        articleImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: topBottomPadding, paddingLeft: 10, paddingBottom: -topBottomPadding, paddingRight: 0, width: 50, height: 50)
        
        //title label
        addSubview(titleLabel)
        let leftPadding:CGFloat = 15
        let labelWidth:CGFloat = 250
        titleLabel.anchor(top: articleImageView.topAnchor, left: articleImageView.rightAnchor, bottom: nil, right: nil, paddingTop: -10, paddingLeft: leftPadding, paddingBottom:0, paddingRight: 0, width: labelWidth, height: 45)
        
        addSubview(categoryLabel)
        categoryLabel.anchor(top: titleLabel.bottomAnchor, left: articleImageView.rightAnchor, bottom: nil, right: nil, paddingTop: -10, paddingLeft: leftPadding, paddingBottom: 0, paddingRight: 0, width:0, height: 0)
        
        //audio player controls
        let buttonSize:CGFloat = 40
        addSubview(forwardTrackBtn)
        forwardTrackBtn.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: buttonSize, height: buttonSize)
        forwardTrackBtn.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(playBtn)
        playBtn.anchor(top: nil, left: nil, bottom: nil, right: forwardTrackBtn.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: buttonSize, height: buttonSize)
        playBtn.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(backTrackBtn)
        backTrackBtn.anchor(top: nil, left: nil, bottom: nil, right: playBtn.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: buttonSize, height: buttonSize)
        backTrackBtn.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

    }
}
