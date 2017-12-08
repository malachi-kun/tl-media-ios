//
//  HomeController.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2017/11/20.
//  Copyright © 2017 Tabi-Labo. All rights reserved.
//
import UIKit
import SDWebImage


class HomeController: UICollectionViewController  {
 
    // MARK: PROPERTIES
    //Get data from server
    let networkManager = NetworkManager()
    
    //Article Model
    var articleDetailedList = [ArticleModel]()
    
//  Controller and Layout Parameters  //**mark for delete**
//    enum catList:String {
//        case voiceArticles
//        case tlFamily
//        case category
//   }
    
    //Image List
    var imageList = [Int:String]()
    var headerImage = UIImage()
    
    //Items To Put Into CollectionView Cells
    var sectionItems:[String] = [cellType.voiceArticle.rawValue, cellType.tlFamily.rawValue, cellType.category.rawValue]
    
    // MARK: COLLECTIONVIEW PROPERTIES
    //COLLECTION VIEW HEADER HEIGHT
    //let headerHeight:CGFloat = 350  //**mark for delete 2017/12/08**
    
    //MAKE CELL HEADER NAMES TO BE REGISTERED  //**mark for delete 2017/12/08**
//    enum headerCellType:String {
//        case headerID
//        case audio
//        case tlFamily
//        case category
//    }
    
    //MAKE COLLECTION VIEW CELL HEIGHT SIZES
    enum sectionCellSizes:CGFloat {
        case voiceArticle = 650
        case tabiLabiFamilyHeight = 550
        case categoryHeight = 475
        case defaultValue = 260
    }
    
    //SECTION TITLE HEADERS
    enum sectionTitle:String {
        case tabiLaboFamily = "TABI LABO FAMILY"
        case category = "CATEGORY"
    }
    
    var headerTitle:[String]?
    
    // MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()

        networkManager.delegate = self
        networkManager.delegateProd = self
        
        collectionView?.backgroundColor = .black
        navigationItem.title = "Tabi Labo"
        headerTitle = ["", sectionTitle.tabiLaboFamily.rawValue, sectionTitle.category.rawValue]
        
        //CELL REGISTRATION
        //header  //**mark for delete 2017/12/08**
//        collectionView?.register(HomeHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerCellType.headerID.rawValue)
        
        //cell registration
        collectionView?.register(VoiceArticle.self, forCellWithReuseIdentifier: cellType.voiceArticle.rawValue)
        collectionView?.register(CategorySection.self, forCellWithReuseIdentifier: cellType.category.rawValue)
        collectionView?.register(TabiLaboFamilySection.self, forCellWithReuseIdentifier: cellType.tlFamily.rawValue)
    }
}




