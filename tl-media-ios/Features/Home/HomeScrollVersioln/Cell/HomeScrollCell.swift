//
//  HomeScrollCell.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2017/12/04.
//  Copyright © 2017 Tabi-Labo. All rights reserved.
//

import UIKit


class HomeScrollCell:UICollectionViewCell {
    // MARK: UI ELEMENTS
    let imageView:UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "TL")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let articleTitleLabel:UILabel = {
        let label = UILabel()
        label.text = "Today is a good day."
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12)
        label.font = UIFont.boldSystemFont(ofSize: 12.0)
        label.textColor = .white
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
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(articleTitleLabel)
        articleTitleLabel.anchor(top: imageView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 15)
        
    }
}
