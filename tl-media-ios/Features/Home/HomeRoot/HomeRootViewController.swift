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
    
    //Get data from server
    let networkManager = HomeNetworking()
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
        homeRootCollectionView.delegate = self
        homeRootCollectionView.dataSource = self
        networkManager.delegateProd = self
        delegate = self
        
        homeRootCollectionView.backgroundColor = .black
        navigationItem.title = navigationTitle
        
        //CELL REGISTRATION
        homeRootCollectionView.register(HomeRootViewArticleCell.self, forCellWithReuseIdentifier: cellType.voiceArticle.rawValue)
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
        
        if indexPath.item < numOfArticles {
            //article cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.voiceArticle.rawValue, for: indexPath) as! HomeRootViewArticleCell
            cell.frame.size.width = UIScreen.main.bounds.width
            
    
            if articleDetails.count > 0{
                cell.voiceArticle.articleImage.sd_setImage(with: URL(string: articleDetails[indexPath.row].images![0]), placeholderImage: #imageLiteral(resourceName: "TL"))
                cell.voiceArticle.titleLabel.text = articleDetails[indexPath.row].title[0]
                return cell
            } else {
                return cell
            }
        } else if indexPath.item == numOfArticles {
            //category
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.tlFamily.rawValue, for: indexPath) as! HomeRootTabiLaboFamilyCell
            return cell
        } else if indexPath.item == numOfArticles + 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.category.rawValue, for: indexPath) as! HomeRootCategoryCell
            return cell
        }

        //default
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.voiceArticle.rawValue, for: indexPath) as! HomeRootViewArticleCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //delegate to HomeRoot
        let selectedIndex = indexPath.row
        delegate?.passArticleDetail(detail: articleDetails[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        switch indexPath.item {
        case 0:
            return CGSize(width: width, height: sectionCellSizes.voiceArticle.rawValue)
        case numOfArticles:
            return CGSize(width: width, height: sectionCellSizes.longSquare.rawValue)
        case numOfArticles+1:
            return CGSize(width: width, height: sectionCellSizes.longSquare.rawValue)
        default:
            return CGSize(width: width, height: sectionCellSizes.defaultValue.rawValue)
        }
    }
    
    // MARK: PREPARE FOR SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueType.articleDetail.rawValue {
            let vc = segue.destination as! HomeArticleDetailController
            vc.articleDetail = articleDetail
        }
    }
    
    // MARK: NETWORK ARTICLE DETAIL DELEGATION
    func articleContentList(articleContent: [ArticleModel]) {
        articleDetails = articleContent
        numOfArticles = articleDetails.count
        DispatchQueue.main.async {
           self.homeRootCollectionView.reloadData()
        }
        print(articleDetails.count)
    }
    
    func passArticleDetail(detail: ArticleModel) {
        articleDetail = detail
        performSegue(withIdentifier: segueType.articleDetail.rawValue, sender: self)
    }
}
