//
//  HomeExpandingScrollTestCell.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2018/01/12.
//  Copyright © 2018 Tabi-Labo. All rights reserved.
//

import UIKit


class HomeExpandingScrollTestCell:UICollectionViewCell {
    
    let textLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n test \n"
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI(){
        addSubview(textLabel)
        textLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: UIScreen.main.bounds.size.width, height: 0)
    }
}
