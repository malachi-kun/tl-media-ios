//
//  VoiceArticleView.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2018/01/15.
//  Copyright © 2018 Tabi-Labo. All rights reserved.
//

import UIKit


class VoiceArticleView:UIView {
    
    // MARK: UI COMPONENTS
    //article image
    let articleImageFirst:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.isUserInteractionEnabled = true
        //iv.backgroundColor = .red
        return iv
    }()
 
    let articleImageSecond:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.isUserInteractionEnabled = true
//        iv.backgroundColor = .green
        return iv
    }()
    
    //multiple line title
    let titleLabelFirst:UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        label.text = "no text found"
        return label
    }()

    let titleLabelSecond:UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        label.text = "no text found"
        return label
    }()
    
    let headsetIcon:UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "headset"), for: .normal)
        button.isUserInteractionEnabled = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ASSIST METHODS
    private func setupView(){
        backgroundColor = .black
        
        setupStackView()
        
        addSubview(titleLabelFirst)
        titleLabelFirst.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: articleImageFirst.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: bounds.width, height: 50)
        
        addSubview(titleLabelSecond)
        titleLabelSecond.anchor(top: nil, left: articleImageSecond.leftAnchor, bottom: bottomAnchor, right: articleImageSecond.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: bounds.width, height: 50)
    }
    
    private func setupStackView(){
            let stackView = UIStackView(arrangedSubviews: [articleImageFirst, articleImageSecond])
            
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.spacing = 1
            
            addSubview(stackView)
            stackView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 100)
    }
}
