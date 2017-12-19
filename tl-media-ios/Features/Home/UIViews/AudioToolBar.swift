//
//  AudioToolBar.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2017/12/19.
//  Copyright © 2017 Tabi-Labo. All rights reserved.
//

import UIKit

class AudioToolBar:UIView{
    
    let articleImageView:UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "TL")
        return iv
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = "This is the title description."
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let issueLabel:UILabel = {
        let label = UILabel()
        label.text = "ISSUE DATE 2017/19/12"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let progressSlide:UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .gray
        slider.setThumbImage(UIImage(), for: .normal)
        return slider
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){

        //article image
        addSubview(articleImageView)
        let topBottomPadding:CGFloat = 15
        articleImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: topBottomPadding, paddingLeft: 10, paddingBottom: -topBottomPadding, paddingRight: 0, width: 50, height: 50)
        
        //title label
        addSubview(titleLabel)
        let leftPadding:CGFloat = 15
        let labelWidth:CGFloat = 250
        titleLabel.anchor(top: topAnchor, left: articleImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: leftPadding, paddingBottom:0, paddingRight: 0, width: labelWidth, height: 45)
        
        //issue label
        addSubview(issueLabel)
        issueLabel.anchor(top: titleLabel.bottomAnchor, left: articleImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: leftPadding, paddingBottom:0, paddingRight: 0, width: labelWidth, height: 15)
        
        
        //progress slider
        addSubview(progressSlide)
        progressSlide.anchor(top: issueLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 15, paddingBottom: -10, paddingRight: 15, width: frame.width, height: 3)
    }
    
}
