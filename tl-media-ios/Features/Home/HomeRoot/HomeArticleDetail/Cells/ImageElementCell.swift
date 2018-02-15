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
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        //iv.isUserInteractionEnabled = true
        //iv.backgroundColor = .green
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
    
 
    func setHeightConversion(height:CGFloat){
        imageContent.heightAnchor.constraint(equalToConstant: height/2).isActive = true
    }
    
    private func setupUI(){
        self.backgroundColor = .white
        addSubview(imageContent)
        
        imageContent.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageContent.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageContent.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        imageContent.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imageContent.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width-1).isActive = true
    }
}
