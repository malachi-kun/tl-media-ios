//
//  Home+CollectionViewController.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2017/12/01.
//  Copyright © 2017 Tabi-Labo. All rights reserved.
//

import UIKit

extension HomeController: UICollectionViewDelegateFlowLayout {
    
    // MARK: COLLECTIONVIEW CODE
    // COLLECTION VIEW CODE
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //HEADER CODE
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCellType.headerID.rawValue, for: indexPath) as! HomeHeader
        
        
        //still in development
        if imageList.count > 0 {
            print(imageList[0] ?? "")
            guard let imageURLString = imageList[0] else {return header}
            header.headerImage.sd_setImage(with: URL(string: imageURLString), placeholderImage: #imageLiteral(resourceName: "TL"))
            return header
        }
        
        if articleDetailedList.count > 0 {
            let imgURLString = articleDetailedList[0].images![0]
            header.headerImage.sd_setImage(with: URL(string: imgURLString), placeholderImage: #imageLiteral(resourceName: "TL"))
            return header
        }
        
        header.headerImage.image = #imageLiteral(resourceName: "TL")
        return header
    }
    
    //CELL CODE
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.topic.rawValue, for: indexPath) as! TopicSection
            return cell
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.tlFamily.rawValue, for: indexPath) as! TabiLaboFamilySection
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.category.rawValue, for: indexPath) as! CategorySection
            return cell
        }
    }
    
    // MARK: FLOW LAYOUT
    //header
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: headerHeight)
    }
    
    //cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        switch indexPath.item {
        case 0:
            return CGSize(width: width, height: sectionCellSizes.topicHeight.rawValue)
        case 1:
            return CGSize(width: width, height: sectionCellSizes.tabiLabiFamilyHeight.rawValue)
        case 2:
            return CGSize(width: width, height: sectionCellSizes.categoryHeight.rawValue)
        default:
            return CGSize(width: width, height: sectionCellSizes.defaultValue.rawValue)
        }
    }
}
