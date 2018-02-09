//
//  NewHomeRootViewControllerCell.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2018/01/12.
//  Copyright © 2018 Tabi-Labo. All rights reserved.
//

import UIKit

class HomeRootViewArticleCell: UICollectionViewCell {
    
    // MARK: UI COMPONENTS
    
    //article views
    let voiceArticle:VoiceArticleView = {
        let va = VoiceArticleView()
        return va
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI(){
        addSubview(voiceArticle)
        voiceArticle.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: UIScreen.main.bounds.width - (2*12), height: 150)
    }
}
