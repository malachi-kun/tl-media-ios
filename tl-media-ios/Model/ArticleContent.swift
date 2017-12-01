//
//  ArticleContent.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2017/11/29.
//  Copyright © 2017 Tabi-Labo. All rights reserved.
//

import UIKit

struct ArticleContentModel:Codable{
    var id:Int?
    var content:String
    var input:String
    
    init(id:Int?, content:String, input:String){
        self.id = id
        self.content = content
        self.input = input
    }
}
