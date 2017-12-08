//
//  HomeScrollController.swift
//  tl-media-ios.
//
//  Created by Malachi Hul on 2017/12/04.
//  Copyright © 2017 Tabi-Labo. All rights reserved.
//

import UIKit
import SDWebImage

class HomeScrollController:UICollectionViewController, UICollectionViewDelegateFlowLayout, ArticleProdDelegate {

    // MARK: PROPERTIES
    let networkManager = NetworkManager()
    var articleDetails = [ArticleModel]()
    
    //Controller and layout parameters
    enum sectionNames:String {
        case voiceArticles
        case tlFamily
        case category
    }
    
    //Section of CollectionView
    var sectionItems:[String] = [sectionNames.voiceArticles.rawValue, sectionNames.tlFamily.rawValue, sectionNames.category.rawValue]
    
    // MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .black
        navigationItem.title = "Tabi Labo"
        
        collectionView?.register(HomeScrollCell.self, forCellWithReuseIdentifier: "cellID")
        networkManager.delegateProd = self
    }
    
    // MARK: COLLECTIONVIEW CONTROLLER
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return articleDetails.count
        default:
            return 0
        }
    }
  
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! HomeScrollCell
        
        cell.imageView.sd_setImage(with: URL(string: articleDetails[indexPath.row].images![0]), placeholderImage: #imageLiteral(resourceName: "TL"))
        return cell
    }
    
    // MARK: FLOW LAYOUT
    //cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 250)
    }
    
    // MARK: DELEGATE METHODS
    func articleContentList(articleContent: [ArticleModel]) {
        articleDetails = articleContent
        collectionView?.reloadData()
    }
}
