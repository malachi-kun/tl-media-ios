//
//  HomeExpandingScrollTest.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2018/01/12.
//  Copyright © 2018 Tabi-Labo. All rights reserved.
//

import UIKit

class HomeExpandingScrollTest:UICollectionViewController {
    
    
    override func viewDidLoad() {
        collectionView?.register(HomeExpandingScrollTestCell.self, forCellWithReuseIdentifier: "test")
        if let flowlayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowlayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
    }
    
    // MARK: COLLECTIONVIEW DATA SOURCE
    // COLLECTION VIEW CODE
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //CELL CODE
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "test", for: indexPath) as! HomeExpandingScrollTestCell
        cell.frame.size.width = view.frame.width
        cell.backgroundColor = .green
        return cell
    }
}
