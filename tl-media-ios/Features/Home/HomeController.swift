//
//  HomeController.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2017/11/20.
//  Copyright © 2017 Tabi-Labo. All rights reserved.
//
import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: PROPERTIES
    enum catList:String {
        case topic
        case tlFamily
        case category
    }
    
    let categoryType:[String] = []
    
    enum headerCellType:String {
        case headerID
        case topic
        case tlFamily
        case category
    }
    
    enum sectionTitle:String {
        case tabiLaboFamily = "TABI LABO FAMILY"
        case category = "CATEGORY"
    }
    
    var headerTitle:[String]?
    
    //items to put into collectionView cells
    var sectionItems:[String] = [catList.topic.rawValue, catList.tlFamily.rawValue, catList.category.rawValue]

    // MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .black
        navigationItem.title = "Tabi Labo"
        headerTitle = ["", sectionTitle.tabiLaboFamily.rawValue, sectionTitle.category.rawValue]
        
        
        //CELL REGISTRATION
        //header
        collectionView?.register(HomeHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerCellType.headerID.rawValue)
        
        //cell registration
        collectionView?.register(TopicSection.self, forCellWithReuseIdentifier: cellType.topic.rawValue)
        collectionView?.register(CategorySection.self, forCellWithReuseIdentifier: cellType.category.rawValue)
        collectionView?.register(TabiLaboFamilySection.self, forCellWithReuseIdentifier: cellType.tlFamily.rawValue)
    }

    // MARK: COLLECTIONVIEW CODE
    // COLLECTION VIEW CODE
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //HEADER CODE
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCellType.headerID.rawValue, for: indexPath) as! HomeHeader
        return header
    }
    
    //CELL CODE
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Section count: \(sectionItems.count)")
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
    
    //FLOW LAYOUT : header
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
    }
    
    //FLOW LAYOUT : cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = view.frame.width
        
        if indexPath.item == 0 {
            return CGSize(width: width, height: 160)
        } else if indexPath.item == 1 {
            return CGSize(width: width, height: 370)
        } else if indexPath.item == 2 {
            return CGSize(width: width, height: 425)
        } else {
            return CGSize(width: width, height: 260)
        }
    }
}
