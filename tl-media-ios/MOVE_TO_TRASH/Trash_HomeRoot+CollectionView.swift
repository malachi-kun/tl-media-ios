//
//  HomeRoot+CollectionView.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2017/12/15.
//  Copyright © 2017 Tabi-Labo. All rights reserved.
//
// CollectionView in the HomeRootController

//import UIKit
//
//extension HomeRootController:UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
// 
//    // MARK: COLLECTIONVIEW DATA SOURCE
//    // COLLECTION VIEW CODE
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    
//    //CELL CODE
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return sectionItems.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if indexPath.item == 0 {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.voiceArticle.rawValue, for: indexPath) as! VoiceArticle
//            cell.delegate = self
//            return cell
//        } else if indexPath.item == 1 {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.tlFamily.rawValue, for: indexPath) as! TabiLaboFamilySection
//            return cell
//        } else {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.category.rawValue, for: indexPath) as! CategorySection
//            return cell
//        }
//    }
//    
//    // MARK: FLOW LAYOUT
//    //cell
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 1
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 1
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        let width = view.frame.width
//        switch indexPath.item {
//        case 0:
//            return CGSize(width: width, height: 650)
//        case 1:
//            return CGSize(width: width, height: 525)
//        default:
//            return CGSize(width: width, height: sectionCellSizes.defaultValue.rawValue)
//        }
//    }
//}

