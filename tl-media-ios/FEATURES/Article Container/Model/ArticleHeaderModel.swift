//
//  ArticleHeaderModel.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2017/12/19.
//  Copyright © 2017 Tabi-Labo. All rights reserved.
//

import Foundation

struct ArticleHeader{
    var id:String
    var description:String
    var issueDate:String

    init(id:String, description:String, issueDate:String){
        self.id = id
        self.description = description
        self.issueDate = issueDate
    }
}
