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
    
    //Article Model
    
    
    //Image List
    var imageList = [Int:String]()
    var headerImage = UIImage()
    
    //Items To Put Into CollectionView Cells
    var sectionItems:[String] = [cellType.voiceArticle.rawValue, cellType.tlFamily.rawValue, cellType.category.rawValue]
    
    //delegate and delegateproperties
    //var delegate:ArticleDetailDelegate?
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
        
        //test network
         
        homeRootCollectionView.delegate = self
        homeRootCollectionView.dataSource = self
        networkManager.delegateProd = self
        delegate = self
        
        homeRootCollectionView.backgroundColor = .black
        navigationItem.title = navigationTitle
        
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
        view.addSubview(homeRootCollectionView)
        homeRootCollectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: -12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
    }
    
    // MARK: COLLECTIONVIEW DELEGATES
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articleDetails.count + 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //print("index:\(indexPath.item) numOfArticles:\(numOfArticles)")
        if indexPath.item < numOfArticles {
            
            //article cell
            //**HeadlineArticleCell
            if indexPath.row == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.headlineArticleCell.rawValue, for: indexPath) as! HomeRootHeadlineArticleCell
                
                cell.frame.size.width = UIScreen.main.bounds.width
                cell.headlineArticle.articleImage.sd_setImage(with: URL(string: articleDetails[indexPath.row].images![0]), placeholderImage: #imageLiteral(resourceName: "TL"))
                cell.headlineArticle.titleLabel.text = articleDetails[indexPath.row].title[0]
                cell.headlineArticle.articleImage.tag = indexPath.row
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(articleImageTapped(tapGestureRecognizer:)))
                cell.headlineArticle.articleImage.tag = indexPath.row
                cell.headlineArticle.articleImage.isUserInteractionEnabled = true
                cell.headlineArticle.articleImage.addGestureRecognizer(tapGestureRecognizer)
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.voiceArticle.rawValue, for: indexPath) as! HomeRootViewArticleCell
               
                if indexPath.row+1 < articleDetails.count {
                    cell.voiceArticle.articleImageFirst.sd_setImage(with: URL(string: articleDetails[indexPath.row].images![0]), placeholderImage: #imageLiteral(resourceName: "TL"))
                    cell.voiceArticle.articleImageSecond.sd_setImage(with: URL(string: articleDetails[indexPath.row+1].images![0]), placeholderImage: #imageLiteral(resourceName: "TL"))
                    
                    //image interaction
                    let firsttapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(firstArticleImageTapped(tapGestureRecognizer:)))
                    let secondtapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(secondArticleImageTapped(tapGestureRecognizer:)))
                    
                  
                    cell.voiceArticle.articleImageFirst.tag = indexPath.row
                    cell.voiceArticle.articleImageSecond.tag = indexPath.row+1
                    cell.voiceArticle.articleImageFirst.addGestureRecognizer(firsttapGestureRecognizer)
                    cell.voiceArticle.articleImageSecond.addGestureRecognizer(secondtapGestureRecognizer)
                    //article label
                    cell.voiceArticle.titleLabelFirst.text = articleDetails[indexPath.row].title[0]
                    cell.voiceArticle.titleLabelSecond.text = articleDetails[indexPath.row+1].title[0]
                } else if indexPath.row+1 == articleDetails.count {
                    cell.voiceArticle.articleImageFirst.sd_setImage(with: URL(string: articleDetails[indexPath.row].images![0]), placeholderImage: #imageLiteral(resourceName: "TL"))
                    cell.voiceArticle.titleLabelFirst.text = articleDetails[indexPath.row].title[0]
                    cell.voiceArticle.headsetIcon.addTarget(self, action: #selector(headsetTapped(withSender:)), for: .touchUpInside)
                }
                return cell
            }
        //Tabi Labo Family
        } else if indexPath.item == numOfArticles {
            //category
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.tlFamily.rawValue, for: indexPath) as! HomeRootTabiLaboFamilyCell
            return cell
            
        //Category
        } else if indexPath.item == numOfArticles + 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.category.rawValue, for: indexPath) as! HomeRootCategoryCell
            return cell
        }

        //default
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.voiceArticle.rawValue, for: indexPath) as! HomeRootViewArticleCell
        return cell
    }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 10
        }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 10
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
        //print("headline tapped, tag: \(tapGestureRecognizer.view?.tag)")
        guard let selectedIndex = tapGestureRecognizer.view?.tag else { return }
        // Delegate
        delegate?.passArticleDetail(detail: articleDetails[selectedIndex])

    }
    
    @objc func firstArticleImageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        //print("first tapped, tag: \(tapGestureRecognizer.view?.tag)")
        guard let selectedIndex = tapGestureRecognizer.view?.tag else { return }
        // Delegate
        delegate?.passArticleDetail(detail: articleDetails[selectedIndex])
        
    }

    @objc func secondArticleImageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        //print("second tapped, tag: \(tapGestureRecognizer.view?.tag)")
        guard let selectedIndex = tapGestureRecognizer.view?.tag else { return }
        // Delegate
        delegate?.passArticleDetail(detail: articleDetails[selectedIndex])
    }

    // MARK: NETWORK ARTICLE DETAIL DELEGATION
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
}
