//
//  HomeRootViewController.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2018/01/12.
//  Copyright © 2018 Tabi-Labo. All rights reserved.
//
import UIKit
import SDWebImage

class HomeRootViewController:UIViewController,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, ArticleDelegate, ArticleDetailDelegate {
   
    

    

    // MARK: UI ELEMENTS
    let homeRootCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    // MARK: PROPERTIES
    var tappedHeadSetIndex:Int?

    //Get data from server
    let networkManager = HomeNetworking(id:nil)
    var articleDetails = [ArticleModel]()
    var indexPressed:Int?
    var delegate:ArticleDetailDelegate?  //delegate to ArticleDetailDelegate
    var authorList:[String:String]?

    //Image List
    var imageList = [Int:String]()
    var headerImage = UIImage()
    
    //Items To Put Into CollectionView Cells
    var sectionItems:[String] = [cellType.voiceArticle.rawValue, cellType.tlFamily.rawValue, cellType.category.rawValue]
    
    //delegate and delegateproperties
    var articleDetail:ArticleModel?
    
    // MARK: COLLECTIONVIEW PROPERTIES
    //MAKE COLLECTION VIEW CELL HEIGHT SIZES
    enum sectionCellSizes:CGFloat {
        case voiceArticle = 50
        case longSquare = 600
        case defaultValue = 260
    }
    
    //SECTION TITLE HEADERS
    enum sectionTitle:String {
        case tabiLaboFamily = "TABI LABO FAMILY"
        case category = "CATEGORY"
    }
    
    var headerTitle:[String]?
    let navigationTitle = "TABI LABO"
    var numOfArticles = Int()
    
    // MARK: LIFECYCLE
    override func viewDidLoad() {
        
        homeRootCollectionView.delegate = self
        homeRootCollectionView.dataSource = self
        
        //DELEGATES
        networkManager.delegateProd = self
        //networkManager.getAuthorList()
        delegate = self
        
        //CELL REGISTRATION
        homeRootCollectionView.register(HomeRootViewArticleCell.self, forCellWithReuseIdentifier: cellType.voiceArticle.rawValue)
        homeRootCollectionView.register(HomeRootHeadlineArticleCell.self, forCellWithReuseIdentifier: cellType.headlineArticleCell.rawValue)
        homeRootCollectionView.register(HomeRootTabiLaboFamilyCell.self, forCellWithReuseIdentifier: cellType.tlFamily.rawValue)
        homeRootCollectionView.register(HomeRootCategoryCell.self, forCellWithReuseIdentifier: cellType.category.rawValue)
        if let flowlayout = homeRootCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowlayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        setupView()
    }
    
    private func setupView(){
        homeRootCollectionView.backgroundColor = UIColor(red: 237/255, green: 238/255, blue: 241/255, alpha: 30.0)
        navigationItem.title = navigationTitle
        
//        // Stop listening notification
//        NotificationCenter.default.removeObserver(self, name: notificationName, object: nil)
        
        view.addSubview(homeRootCollectionView)
        homeRootCollectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: -12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        
    }
    
    // MARK: PREPARE FOR SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueType.articleDetail.rawValue {
            let vc = segue.destination as! HomeArticleDetailController
            vc.articleDetail = articleDetail
        }
    }
    
    // MARK: ASSIST METHODS
    @objc func headsetTapped(withSender: AnyObject){
        guard (withSender.tag) != nil else { return }

        // MARK: NotificationCenter
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationCalls.playAudioArticlePressed.rawValue), object: self, userInfo: [notificationCalls.articleDetails.rawValue:articleDetails[withSender.tag]])
    }
    
    @objc func articleImageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        guard let selectedIndex = tapGestureRecognizer.view?.tag else { return }
        // Delegate
        delegate?.passArticleDetail(detail: articleDetails[selectedIndex])
    }
    
    @objc func redPlayTapped(tapGestureRecognizer: UITapGestureRecognizer){
        guard let selectedIndex = tapGestureRecognizer.view?.tag else { return }
 
        // MARK: NOTIFICATION CENTER
        // Define identifier and Post notification
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationCalls.playAudioArticlePressed.rawValue), object: self, userInfo: [notificationCalls.articleDetails.rawValue:articleDetails[selectedIndex]])
    }

    // MARK: NETWORK DELEGATION
    func articleContentList(articleContent: [ArticleModel]) {
        articleDetails = articleContent
        numOfArticles = articleDetails.count

        DispatchQueue.main.async {
           self.homeRootCollectionView.reloadData()
        }
    }
    
    func passArticleDetail(detail: ArticleModel) {
        articleDetail = detail
        performSegue(withIdentifier: segueType.articleDetail.rawValue, sender: self)
    }
    
    func authorList(authors: [String : String]) {
        self.authorList = authors
        
        DispatchQueue.main.async {
            self.homeRootCollectionView.reloadData()
        }
    }
}
