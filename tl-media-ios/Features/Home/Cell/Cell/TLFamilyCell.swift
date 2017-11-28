//
//  tlFamily.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2017/11/21.
//  Copyright © 2017 Tabi-Labo. All rights reserved.
//

import UIKit

class TLFamilyCell:UICollectionViewCell {
    // MARK: UI ELEMENTS
    let imageView:UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "TL")
        iv.contentMode = .scaleAspectFit
        //iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.text = "Name of row"
        label.font = UIFont.systemFont(ofSize: 12)
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
        addSubview(nameLabel)
        
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        //nameLabel.anchor(top: imageView.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 5, paddingRight: 0, width: 0, height: 0)
        
    }
}
