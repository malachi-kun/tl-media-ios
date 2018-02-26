//
//  HomeArticleElements.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2018/02/13.
//  Copyright © 2018 Tabi-Labo. All rights reserved.
//

import UIKit

class HomeArticleSentenceCell:UICollectionViewCell {
    // MARK: UI COMPONENTS
    //article image
    let inputTypeLabel:UILabel = {
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
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        addSubview(inputTypeLabel)
        inputTypeLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: UIScreen.main.bounds.size.width-24, height: 0)
    }
}
