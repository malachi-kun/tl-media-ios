//
//  Home+Protocols.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2017/12/04.
//  Copyright © 2017 Tabi-Labo. All rights reserved.
//  Protocols for HomeRootController.

import UIKit

//Gets article details from the network to HomeController.
protocol ArticleDelegate {
    func articleContentList(articleContent:[ArticleModel])
}

//Sends article details from HomeController to HomeArticleDetailController
protocol ArticleDetailDelegate{
    func passArticleDetail(detail:ArticleModel)
}

protocol ArticleElementListDelegate{
    func getArticleElements(elements:[ArticleDetailElementModel])
}

protocol ImageResizeDelegate{
    func imageResizer(url:String, image:UIImage, ratio:CGFloat)
}

