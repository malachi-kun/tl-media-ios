//
//  Home+Protocols.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2017/12/04.
//  Copyright © 2017 Tabi-Labo. All rights reserved.
//  Protocols for HomeRootController.

import UIKit

// MARK: NETWORK DELEGATION
//Gets article details from the NETWORK to HOMEVIEWCONTROLLER.
protocol ArticleDelegate {
    func articleContentList(articleContent:[ArticleModel])
    func authorList(authors:[String:String])
}

// MARK: ARTICLE DETAIL DELEGATION
//Sends article details from HomeController to HomeArticleDetailController
protocol ArticleDetailDelegate{
    func passArticleDetail(detail:ArticleModel)
}

//article detail images to Article detail
protocol ArticleElementListDelegate{
    func getArticleElements(elements:[ArticleDetailElementModel])
}

