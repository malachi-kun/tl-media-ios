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
    
    //Controller and layout parameters
    enum catList:String {
        case voiceArticles
        case tlFamily
        case category
    }
    
    //image list
    var imageList = [Int:String]()
    var headerImage = UIImage()
    
    //items to put into collectionView cells
    var sectionItems:[String] = [catList.voiceArticles.rawValue, catList.tlFamily.rawValue, catList.category.rawValue]
    
    //MARK COLLECTION VIEW HEADER HEIGHT
    let headerHeight:CGFloat = 350
    
    //MAKE CELL HEADER NAMES TO BE REGISTERED
    enum headerCellType:String {
        case headerID
        case topic
        case tlFamily
        case category
    }
    
    //MAKE COLLECTION VIEW CELL HEIGHT SIZES
    enum sectionCellSizes:CGFloat {
        case topicHeight = 160
        case tabiLabiFamilyHeight = 370
        case categoryHeight = 425
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
        //header
        collectionView?.register(HomeHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerCellType.headerID.rawValue)
        
        //cell registration
        collectionView?.register(TopicSection.self, forCellWithReuseIdentifier: cellType.topic.rawValue)
        collectionView?.register(CategorySection.self, forCellWithReuseIdentifier: cellType.category.rawValue)
        collectionView?.register(TabiLaboFamilySection.self, forCellWithReuseIdentifier: cellType.tlFamily.rawValue)
    }
}




