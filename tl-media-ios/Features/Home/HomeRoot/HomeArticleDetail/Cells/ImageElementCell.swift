//
//  ImageElementCell.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2018/02/13.
//  Copyright © 2018 Tabi-Labo. All rights reserved.
//

import UIKit

class ImageElementCell:UICollectionViewCell {
    
    //UI Components
    let imageContent:UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "whiteBackGround")
        iv.contentMode = .scaleToFill
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    // MARK: LIFECYCLE
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //
    private func setupUI(){
        addSubview(imageContent)
        imageContent.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: UIScreen.main.bounds.size.width-24, height: 220)
    }
}
