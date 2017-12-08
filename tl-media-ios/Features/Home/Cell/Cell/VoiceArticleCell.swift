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
    
    let titleLabel:UIView = {
       let label = UILabel()
        label.text = "This is a title."
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
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
        bringSubview(toFront: topLayer)
        addSubview(titleLabel)
        
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        
        topLayer.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        titleLabel.anchor(top: topLayer.topAnchor, left: topLayer.leftAnchor, bottom: nil, right: topLayer.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
}
