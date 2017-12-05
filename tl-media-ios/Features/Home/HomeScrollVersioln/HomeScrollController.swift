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
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articleDetails.count
    }
  
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! HomeScrollCell
        
        cell.imageView.sd_setImage(with: URL(string: articleDetails[indexPath.row].images![0]), placeholderImage: #imageLiteral(resourceName: "TL"))
        cell.articleTitleLabel.text = articleDetails[indexPath.row].author
        return cell
    }
    
    // MARK: FLOW LAYOUT
    //header
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: view.frame.width, height: view.frame.width)
//    }
    
    //cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 250)
    }
    
    // MARK: DELEGATE METHODS
    func articleContentList(articleContent: [ArticleModel]) {
        
        var count = 0
        
        for article in articleContent {
//            for imageString in article.images {
//                imageList.append(imageString)
//                count += 1
//            }
            articleDetails = articleContent
     
        }
        
        print(count)
        collectionView?.reloadData()
    }
}
