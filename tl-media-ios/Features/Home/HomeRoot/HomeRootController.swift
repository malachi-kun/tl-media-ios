//
//  HomeRootController.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2017/12/14.
//  Copyright © 2017 Tabi-Labo. All rights reserved.
//
// RootViewController for the Main Container View

import UIKit
import SDWebImage

class HomeRootController:UIViewController {
    
    // MARK: UI ELEMENTS
    let homeRootCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    // MARK: LIFECYCLE
    override func viewDidLoad() {
        homeRootCollectionView.delegate = self
        homeRootCollectionView.dataSource = self
        
        networkManager.delegateProd = self
        
        homeRootCollectionView.backgroundColor = .black
        navigationItem.title = navigationTitle
        headerTitle = ["", sectionTitle.tabiLaboFamily.rawValue, sectionTitle.category.rawValue]
        
        //CELL REGISTRATION
        homeRootCollectionView.register(VoiceArticle.self, forCellWithReuseIdentifier: cellType.voiceArticle.rawValue)
        homeRootCollectionView.register(CategorySection.self, forCellWithReuseIdentifier: cellType.category.rawValue)
        homeRootCollectionView.register(TabiLaboFamilySection.self, forCellWithReuseIdentifier: cellType.tlFamily.rawValue)
        
        setupView()
    }
    
    private func setupView(){
        view.addSubview(homeRootCollectionView)
        homeRootCollectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: -12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
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
    
    //delegate and delegateproperties
    var delegate:ArticleDetailDelegate?
    var articleDetail:ArticleDetailModel?
    
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
    let navigationTitle = "TABI LABO"
    
    
    // MARK: PREPARE FOR SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueType.articleDetail.rawValue {
            let vc = segue.destination as! HomeArticleDetailController
            vc.articleDetail = articleDetail
        }
    }
}
