//
//  ArticleDetailElements.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2018/02/13.
//  Copyright © 2018 Tabi-Labo. All rights reserved.
//

import UIKit

struct ArticleDetailElementModel {
    var index:Int
    var inputType:String
    var content:String
    
    init(index:Int, inputType:String, content:String){
        self.index = index
        self.inputType = inputType
        self.content = content
    }
}
