//
//  Home+Protocols.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2017/12/04.
//  Copyright © 2017 Tabi-Labo. All rights reserved.
//  Protocols for HomeRootController.

import Foundation


// MARK: Dec 4, 2017 - Dev code and dev structure.  Please to remove once I get full requirements in the design.
protocol ArticleContentDelegate{
    func articleContentList(articleModelList:[ArticleContentModel], articleContentModelList:[Int:[ArticleContentModel]])
}

protocol ArticleProdDelegate {
    func articleContentList(articleContent:[ArticleModel])
}


