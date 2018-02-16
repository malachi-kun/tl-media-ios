//
//  HomeRootHeadlinea=.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2018/02/01.
//  Copyright © 2018 Tabi-Labo. All rights reserved.
//

import UIKit

class HomeRootHeadlineArticleCell:UICollectionViewCell {
    
    let headlineArticle:HeadlineArticeView = {
        let hA = HeadlineArticeView()
        return hA
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI(){
        addSubview(headlineArticle)
        headlineArticle.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: UIScreen.main.bounds.width - 2, height: 200)
    }
    
    
}

