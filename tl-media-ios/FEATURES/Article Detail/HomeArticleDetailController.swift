//
//  HomeArticleDetail.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2018/01/09.
//  Copyright © 2018 Tabi-Labo. All rights reserved.
//

import UIKit
import SDWebImage

class HomeArticleDetailController:UIViewController {
    
    // MARK: UI COMPONENTS
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.isScrollEnabled = true
        collectionView.isUserInteractionEnabled = true
        collectionView.alwaysBounceVertical = true
        return collectionView
    }()
    
    // MARK: PROPERTIES
    enum cellID:String{
        case HomeArticleDetailCell
        case ArticleSentenceElement
        case ImageContent
    }
    
    var estimatedSize:CGSize?
    var articleDetail:ArticleModel?
    var articleElements:[ArticleDetailElementModel]?
    

    //URL: (Image,Ratio)
    //var imageDict = [String: (image:UIImage, ratio:CGFloat)]()
    
    // MARK: LIFECYCLE
    override func viewDidLoad() {
        //Cell registration
        collectionView.register(HomeArticleDetailCell.self, forCellWithReuseIdentifier: cellID.HomeArticleDetailCell.rawValue)
        collectionView.register(HomeArticleSentenceCell.self, forCellWithReuseIdentifier: cellID.ArticleSentenceElement.rawValue)
        collectionView.register(ImageElementCell.self, forCellWithReuseIdentifier: cellID.ImageContent.rawValue)
        if let flowlayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowlayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }

        //delegate
        //imageDelegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        estimatedSize = UICollectionViewFlowLayoutAutomaticSize
        
        getArticleDetails()
        setUpUI()
    }
    
    // MARK: ASSIST METHODS
    private func setUpUI(){
        view.backgroundColor = .black
        
        //navigation bar button
        let downloadBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "DownloadIcon"), style: .plain, target: self, action: #selector(downloadPressed))
        self.navigationItem.rightBarButtonItem  = downloadBarButton
        
        view.addSubview(collectionView)
        collectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    @objc private func downloadPressed(){
        print("download pressed")
    }
    
    private func getArticleDetails(){
        //get article details
        guard let id = articleDetail?.id else {return}
        let networkManager = ArticleNetworkService(id: id)
        networkManager.delegateElements = self
    }
    
//    func downloadArticleImages(elements:[ArticleDetailElementModel]){
//        guard let articleElements = articleElements else {return}
//            for image in articleElements {
//          
//                if image.inputType == cellType.image.rawValue {
//                    downloadImage(urlString: image.content)
//                }
//            }
//    }
}
