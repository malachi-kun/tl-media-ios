//
//  HomeArticleDetail+CollectionView.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2018/01/10.
//  Copyright © 2018 Tabi-Labo. All rights reserved.
//

import UIKit

extension HomeArticleDetailController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: COLLECTIONVIEW DATA SOURCE
    // COLLECTION VIEW CODE
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //CELL CODE
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID.HomeArticleDetailCell.rawValue, for: indexPath) as! HomeArticleDetailCell
        cell.frame.size.width = collectionView.frame.size.width
        return cell
    }
    
    // MARK: COLLECTIONVIEW FLOW LAYOUT
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
