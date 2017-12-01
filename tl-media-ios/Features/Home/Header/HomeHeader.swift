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
    var headerImage:UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "TL")  //fileName : default image
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .black
        return iv
    }()
    
    // MAARK: PROPERTIES
    var imageURL:String?
    
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
        
        headerImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
}
