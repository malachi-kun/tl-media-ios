//
//  CategoryCell.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2017/11/21.
//  Copyright © 2017 Tabi-Labo. All rights reserved.
//

import UIKit

class CategoryCell:UICollectionViewCell {
    
    // MARK: UI ELEMENTS
    let imageView:UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        //iv.image = UIImage(named: "TL")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    
    // MARK: LIFECYCLE
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        backgroundColor = .black
        
        addSubview(imageView)
        
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
