//
//  HomeArticleDetailController+Delegates.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2018/02/13.
//  Copyright © 2018 Tabi-Labo. All rights reserved.
//

import UIKit


extension HomeArticleDetailController:ArticleElementListDelegate {
    func getArticleElements(elements: [ArticleDetailElementModel]) {
        articleElements = elements
        //downloadArticleImages(elements:elements)  //MARK FOR DELETE 2018/02/15
        collectionView.reloadData()
    }
}
