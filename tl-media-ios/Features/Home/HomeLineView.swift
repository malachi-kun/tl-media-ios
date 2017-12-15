//
//  HomeLineView.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2017/12/14.
//  Copyright © 2017 Tabi-Labo. All rights reserved.
//

import UIKit


class HomeLineView:UIView {
    
    // MARK: UI ELEMENTS
    let titleLabel:UILabel = {
       let label = UILabel()
        label.text = "This is an audio title."
        return label
    }()
    
    // MARK: LIFECYCLE
    override init(frame: CGRect) {
        super.init(frame: frame) // calls designated initializer
        setupView()
    }

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK ASSIST METHODS
    private func setupView(){
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 20, height: 5)
    }
}
