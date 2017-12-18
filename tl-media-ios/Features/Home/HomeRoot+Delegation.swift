//
//  HomeRoot+Delegation.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2017/12/15.
//  Copyright © 2017 Tabi-Labo. All rights reserved.
//

import UIKit


extension HomeRootController:ArticleContentDelegate, ArticleProdDelegate{
    
    // MARK: DELEGATION
    func articleContentList(articleModelList: [ArticleContentModel], articleContentModelList: [Int : [ArticleContentModel]]) {
        
        var i = 0
        for inputType in articleModelList {
            if inputType.input == "image"{
                self.imageList[i] = inputType.content
                print("raw: \(inputType.content) \n iL:\(String(describing: imageList[i]))")
                i += 1
            }
        }
        DispatchQueue.main.async {
            self.homeRootCollectionView.reloadData()
        }
    }
    
    func articleContentList(articleContent: [ArticleModel]) {
        self.articleDetailedList = articleContent
        self.homeRootCollectionView.reloadData()
    }
    
}

