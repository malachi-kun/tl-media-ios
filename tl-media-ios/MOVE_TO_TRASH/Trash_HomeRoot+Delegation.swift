//
//  HomeRoot+Delegation.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2017/12/15.
//  Copyright © 2017 Tabi-Labo. All rights reserved.
//

//import UIKit
//
//
//extension HomeRootController: ArticleDelegate, ArticleDetailDelegate{
//
//    // MARK: DELEGATION
//    func articleContentList(articleModelList: [ArticleContentModel], articleContentModelList: [Int : [ArticleContentModel]]) {
//        
//        var i = 0
//        for inputType in articleModelList {
//            if inputType.input == "image"{
//                self.imageList[i] = inputType.content
//                i += 1
//            }
//        }
//        DispatchQueue.main.async {
//            self.homeRootCollectionView.reloadData()
//        }
//    }
//    
//    func articleContentList(articleContent: [ArticleModel]) {
//        self.articleDetailedList = articleContent
//        self.homeRootCollectionView.reloadData()
//    }
//    
//    //get data from articleDetail and segue to HomeArticleDetail VC
//    func passArticleDetail(detail: ArticleModel) {
//        print("test passing article detail data to  HOMEROOT")
//        articleDetail = detail
//        performSegue(withIdentifier: segueType.articleDetail.rawValue, sender: self)
//    }
//    
//}

