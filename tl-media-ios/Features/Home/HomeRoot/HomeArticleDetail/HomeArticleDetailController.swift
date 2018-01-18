//
//  HomeArticleDetail.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2018/01/09.
//  Copyright © 2018 Tabi-Labo. All rights reserved.
//

import UIKit

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
    }
    
    var estimatedSize:CGSize?
    var articleDetail:ArticleModel?

    
    // MARK: LIFECYCLE
    override func viewDidLoad() {
        collectionView.register(HomeArticleDetailCell.self, forCellWithReuseIdentifier: cellID.HomeArticleDetailCell.rawValue)
        if let flowlayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowlayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        estimatedSize = UICollectionViewFlowLayoutAutomaticSize
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
}
