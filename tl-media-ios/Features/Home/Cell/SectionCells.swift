//
//  SectionCells.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2017/11/21.
//  Copyright © 2017 Tabi-Labo. All rights reserved.
//

import UIKit

class SectionCells:UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: UI ELEMENTS
    let tabiLaboFamilysectionLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "TABI LABO FAMILY"
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    // MARK: LIFECYCLE
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: PROPERTIES
    let topicCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //collectionView.backgroundColor = .blue
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let tlFamilyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        //layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //collectionView.backgroundColor = .blue
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        //layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //collectionView.backgroundColor = .blue
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    enum cellType:String {
        case topicCell
        case tlFamily
        case category
    }
    
    func setupView(){
        
        
        //datasource and delegate
        topicCollectionView.dataSource = self
        topicCollectionView.delegate = self
        
        //register cells
        topicCollectionView.register(TopicCell.self, forCellWithReuseIdentifier: cellType.topicCell.rawValue)
        tlFamilyCollectionView.register(TopicCell.self, forCellWithReuseIdentifier: cellType.tlFamily.rawValue)
        categoryCollectionView.register(TopicCell.self, forCellWithReuseIdentifier: cellType.category.rawValue)
        
        
        //auto layout
        addSubview(tabiLaboFamilysectionLabel)
        tabiLaboFamilysectionLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tabiLaboFamilysectionLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        
        addSubview(topicCollectionView)
        topicCollectionView.topAnchor.constraint(equalTo: tabiLaboFamilysectionLabel.bottomAnchor).isActive = true
        topicCollectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        topicCollectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        topicCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellType.topicCell.rawValue, for: indexPath) as! TopicCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: frame.height)
    }
}

