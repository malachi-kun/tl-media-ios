//
//  VoiceArticleView.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2018/01/15.
//  Copyright © 2018 Tabi-Labo. All rights reserved.
//

import UIKit


class VoiceArticleView:UIView {
    
    // MARK: UI COMPONENTS
    //article image
    let articleImage:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .black
        return iv
    }()
    
    //multiple line title
    let titleLabel:UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .black
        label.text = "no text found"
        return label
    }()
    
    //headset icon
//    let headsetIcon:UIImageView = {
//        let iv = UIImageView()
//        iv.image = #imageLiteral(resourceName: "headset")
//        iv.backgroundColor = .black
//        return iv
//    }()
    
    let headsetIcon:UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "headset"), for: .normal)
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
        backgroundColor = .black
        
        addSubview(articleImage)
        articleImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
        
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: articleImage.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 200, height: 50)
        
        addSubview(headsetIcon)
        headsetIcon.anchor(top: topAnchor, left: titleLabel.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
    }
    
}
