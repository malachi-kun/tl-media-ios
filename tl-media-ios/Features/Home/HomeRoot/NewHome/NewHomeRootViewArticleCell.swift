//
//  NewHomeRootViewControllerCell.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2018/01/12.
//  Copyright © 2018 Tabi-Labo. All rights reserved.
//

import UIKit

class NewHomeRootViewArticleCell: UICollectionViewCell {
    
    // MARK: UI COMPONENTS
    let articleImage:UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .purple
        return iv
    }()
    
    //article views
    let voiceArticle:VoiceArticleView = {
        let va = VoiceArticleView()
        return va
    }()
    
    let voiceArticleTwo:VoiceArticleView = {
        let va = VoiceArticleView()
        return va
    }()
    
    let voiceArticleThree:VoiceArticleView = {
        let va = VoiceArticleView()
        return va
    }()
    
    let voiceArticleFour:VoiceArticleView = {
        let va = VoiceArticleView()
        return va
    }()
    
    let voiceArticleFive:VoiceArticleView = {
        let va = VoiceArticleView()
        return va
    }()
    
    let articleHeaderLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.sizeToFit()
        label.text = "New Article"
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
        
        addSubview(voiceArticle)
        voiceArticle.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: UIScreen.main.bounds.width - (2*12), height: 50)
        
//        addSubview(articleHeaderLabel)
//        articleHeaderLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 100, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: UIScreen.main.bounds.size.width - 24, height: 50)
        
        
        //stackView
//        let stackView = UIStackView(arrangedSubviews: [voiceArticleOne,voiceArticleTwo])
//
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.axis = .vertical
//        stackView.distribution = .fillEqually
//        stackView.spacing = 5
//
//        addSubview(stackView)
//        stackView.anchor(top: articleHeaderLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 100)
        
        
    }
}
