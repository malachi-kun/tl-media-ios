//
//  NewHomeRootTabiLaboFamilyCell.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2018/01/15.
//  Copyright © 2018 Tabi-Labo. All rights reserved.
//

import UIKit

class HomeRootTabiLaboFamilyCell:UICollectionViewCell {
    
    // MARK: UI COMPONENTS
    let tabiLaboLabel:UILabel = {
        let label = UILabel()
        label.text = "Tabi Labo Family"
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let beeImage:UIImageView = {
    let iv = UIImageView()
    iv.image = #imageLiteral(resourceName: "brands_be_logo")
    return iv
    }()
    
    let localImage:UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "brands_tl_logo")
        return iv
    }()
    
    let goImage:UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "brands_go_logo")
        return iv
    }()
    
    let journeyImage:UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "brands_go_logo")
        return iv
    }()
    
    let takiBitoImage:UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "brands_takibito_logo")
        return iv
    }()
    
    let BPMBitoImage:UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "brands_diccovery_logo")
        return iv
    }()
    
    
    // MARK: PROPERTIES
    var cellImages = [UIImage]()
    
    // MARK: LIFECYCLE
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: ASSIST METHODS
    private func setupimageLogoArray(){
        cellImages = [#imageLiteral(resourceName: "brands_go_logo"),#imageLiteral(resourceName: "brands_tl_logo"),#imageLiteral(resourceName: "brands_be_logo"),#imageLiteral(resourceName: "brands_jl_logo1"),#imageLiteral(resourceName: "brands_takibito_logo"),#imageLiteral(resourceName: "brands_diccovery_logo")]
    }
    
    private func setUpUI(){
        
        let squareDimension = (frame.size.width / 2) - 2
        let cellWidth:CGFloat = squareDimension
        let cellHeight:CGFloat = squareDimension
        
        addSubview(tabiLaboLabel)
        tabiLaboLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 0)
        
        addSubview(beeImage)
        beeImage.anchor(top: tabiLaboLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: cellWidth, height: cellHeight)
        
        addSubview(localImage)
        localImage.anchor(top: tabiLaboLabel.bottomAnchor, left: beeImage.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: cellWidth, height: cellHeight)
        
        addSubview(goImage)
        goImage.anchor(top: beeImage.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: cellWidth, height: cellHeight)
        
        addSubview(journeyImage)
        journeyImage.anchor(top: beeImage.bottomAnchor, left: goImage.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: cellWidth, height: cellHeight)
        
        addSubview(takiBitoImage)
        takiBitoImage.anchor(top: journeyImage.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: cellWidth, height: cellHeight)
        
        addSubview(BPMBitoImage)
        BPMBitoImage.anchor(top: journeyImage.bottomAnchor, left: takiBitoImage.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: cellWidth, height: cellHeight)
    }
    
    
}
