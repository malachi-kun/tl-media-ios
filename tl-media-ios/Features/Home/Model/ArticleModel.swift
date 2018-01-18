//
//  ArticleModel.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2017/12/04.
//  Copyright © 2017 Tabi-Labo. All rights reserved.
//

import UIKit

struct ArticleModel {
    var id:String
    var status:String
    var author:String
    var title:[String]
    var images:[String]?
    var body:String
    var postDate:String
    
    init(id:String, status:String, author:String, title:[String], body:String, images:[String], postDate:String){
        self.id = id
        self.status = status
        self.author = author
        self.title = title
        self.images = images
        self.body = body
        self.postDate = postDate
    }
}
