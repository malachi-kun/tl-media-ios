//
//  Article.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2018/02/14.
//  Copyright © 2018 Tabi-Labo. All rights reserved.
//

import UIKit

class ArticleView:UIView{
    //UI COMPONENTS
    
    //article image
    let articleImageFirst:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    let titleLabelFirst:UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        label.text = "no text found"
        return label
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
        
        addSubview(articleImageFirst)
        articleImageFirst.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        addSubview(titleLabelFirst)
        titleLabelFirst.anchor(top: nil, left: articleImageFirst.leftAnchor, bottom: articleImageFirst.bottomAnchor, right: articleImageFirst.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
    }
}
