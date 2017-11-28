//
//  CategorySection.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2017/11/27.
//  Copyright © 2017 Tabi-Labo. All rights reserved.
//

import UIKit

class CategorySection:UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: PROPERTIES
    let categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        //collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let categoryLabel:UILabel = {
        let label = UILabel()
        label.text = "Category"
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: PROPERTIES

    
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
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        addSubview(categoryLabel)
        addSubview(categoryCollectionView)
        categoryCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: cellType.category.rawValue)
        
        //auto layout
        
        categoryLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 0)

        categoryCollectionView.anchor(top: categoryLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
//        categoryLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        categoryLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
//        categoryLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
//
//        categoryCollectionView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 3).isActive = true
//        categoryCollectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
//        categoryCollectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
//        categoryCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    // MARK: COLLECTIONVIEW
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.category.rawValue, for: indexPath) as! CategoryCell
        
        print("category index: \(indexPath.item)")
        return cell
    }
    
    // MARK: COLLECTIONVIEW VIEW DELEGATE
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

