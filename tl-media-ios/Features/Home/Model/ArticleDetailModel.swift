//
//  ArticleDetailModel.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2018/01/09.
//  Copyright © 2018 Tabi-Labo. All rights reserved.
//

import UIKit

struct ArticleDetailModel{
    var id:Int?
    var header:String
    var paragraph:String
    var articleImage = UIImage()
    
    init(id:Int, header:String, paragraph:String, articleImage:UIImage){
        self.id = id
        self.header = header
        self.paragraph = paragraph
        self.articleImage = articleImage
    }
}


