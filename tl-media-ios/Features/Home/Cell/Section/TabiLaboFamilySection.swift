//
//  SectionCells.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2017/11/21.
//  Copyright © 2017 Tabi-Labo. All rights reserved.
//

import UIKit

class TabiLaboFamilySection:UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    // MARK: UI Components
    let tabiLaboFamilyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        return collectionView
    }()
    
    let tabiLaboLabel:UILabel = {
        let label = UILabel()
        label.text = "Tabi Labo Family"
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: PROPERTIES

    let numberOfSections = 6
    
    //MARK: LIFECYCLE
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ASSIST METHODS
    func setupView(){
        
        backgroundColor = .black
        tabiLaboFamilyCollectionView.delegate = self
        tabiLaboFamilyCollectionView.dataSource = self
        
        addSubview(tabiLaboLabel)
        addSubview(tabiLaboFamilyCollectionView)
        
        //cell registeration
        tabiLaboFamilyCollectionView.register(TLFamilyCell.self, forCellWithReuseIdentifier: cellType.tlFamily.rawValue)
        
        //auto layout
        tabiLaboLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 0)
        tabiLaboFamilyCollectionView.anchor(top: tabiLaboLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    // MARK: COLLECTIONVIEW
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.tlFamily.rawValue, for: indexPath) as! TLFamilyCell
        return cell
    }
    
    // MARK: COLLECTIONVIEW VIEW DELEGATE
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (frame.width - 1) / 2
        return CGSize(width: width, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

