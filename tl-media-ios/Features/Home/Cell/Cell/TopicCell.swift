//
//  topicCell.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2017/11/21.
//  Copyright © 2017 Tabi-Labo. All rights reserved.
//

import UIKit

class TopicCell:UICollectionViewCell {
    
    // MARK: UI ELEMENTS
    let imageView:UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "TL")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let articleTitleLabel:UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont.systemFont(ofSize: 25)
        label.font = UIFont.boldSystemFont(ofSize: 25.0)
        label.textColor = .white
        return label
    }()
    
    let articleDescriptionLabel:UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.font = UIFont.systemFont(ofSize: 15)
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
    
    // MARK: UI CODE
    func setupView(){
        backgroundColor = .black
        
        addSubview(imageView)
        addSubview(articleTitleLabel)
        addSubview(articleDescriptionLabel)
        
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)

        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}
