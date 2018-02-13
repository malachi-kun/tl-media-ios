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
        iv.image = #imageLiteral(resourceName: "card01")
        iv.contentMode = .scaleToFill
        iv.backgroundColor = .black
        return iv
    }()
    
    //multiple line title
    let titleLabel:UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        label.text = "no text found"
        return label
    }()
    
    let headsetIcon:UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "headset"), for: .normal)
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
        backgroundColor = .black
        
        addSubview(articleImage)
        articleImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: bounds.width, height: bounds.height)
        
        addSubview(titleLabel)
        titleLabel.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: bounds.width, height: 50)

//        addSubview(headsetIcon)
//        headsetIcon.anchor(top: topAnchor, left: titleLabel.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
    

    }
}
