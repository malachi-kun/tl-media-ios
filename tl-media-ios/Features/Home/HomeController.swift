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
    let networkManager = HomeNetworking()
    
    //Article Model
    var articleDetailedList = [ArticleModel]()
    
    //Image List
    var imageList = [Int:String]()
    var headerImage = UIImage()
    
    //Items To Put Into CollectionView Cells
    var sectionItems:[String] = [cellType.voiceArticle.rawValue, cellType.tlFamily.rawValue, cellType.category.rawValue]
    
    // MARK: COLLECTIONVIEW PROPERTIES
    //MAKE COLLECTION VIEW CELL HEIGHT SIZES
    enum sectionCellSizes:CGFloat {
        case voiceArticle = 650
        case tabiLabiFamilyHeight = 525
        case categoryHeight = 430
        case defaultValue = 260
    }
    
    //SECTION TITLE HEADERS
    enum sectionTitle:String {
        case tabiLaboFamily = "TABI LABO FAMILY"
        case category = "CATEGORY"
    }
    
    var headerTitle:[String]?
    let navigationTitle = "Tabi Labo"
    
    // MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()

        networkManager.delegate = self
        networkManager.delegateProd = self
        
        collectionView?.backgroundColor = .black
        navigationItem.title = navigationTitle
        headerTitle = ["", sectionTitle.tabiLaboFamily.rawValue, sectionTitle.category.rawValue]
        
        //CELL REGISTRATION
        collectionView?.register(VoiceArticle.self, forCellWithReuseIdentifier: cellType.voiceArticle.rawValue)
        collectionView?.register(CategorySection.self, forCellWithReuseIdentifier: cellType.category.rawValue)
        collectionView?.register(TabiLaboFamilySection.self, forCellWithReuseIdentifier: cellType.tlFamily.rawValue)
    }
}




