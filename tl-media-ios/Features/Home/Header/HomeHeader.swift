//
//  HomeHeader.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2017/11/20.
//  Copyright © 2017 Tabi-Labo. All rights reserved.
//

import UIKit


class HomeHeader:UICollectionViewCell {
    
    // MARK: UI ELEMENTS
    let headerImage:UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .green
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    // MARK: LIFECYCLE CODE
    override init(frame: CGRect){
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: HELPER METHODS
    private func setupUI(){
        addSubview(headerImage)
        headerImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        headerImage.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        headerImage.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        headerImage.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
