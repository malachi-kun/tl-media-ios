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
        iv.image = #imageLiteral(resourceName: "blackBackGround")
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .black
        return iv
    }()
    
    //multiple line title
    let titleLabel:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.backgroundColor = .white
        //label.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        label.text = "no text found"
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
        backgroundColor = .black
        
        addSubview(articleImage)
        articleImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: bounds.width, height: bounds.height)
        

        addSubview(titleLabel)
        titleLabel.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: bounds.width, height: 50)
        
        addSubview(redPlayIcon)
        redPlayIcon.anchor(top: nil, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: -33, paddingRight: 12, width: 0, height: 0)
    }
}
