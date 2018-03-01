//
//  Playlist.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2018/02/28.
//  Copyright © 2018 Tabi-Labo. All rights reserved.
//

import UIKit

class PlayListItem {
    var title:String
    var url:URL
    
    init(title:String, url:URL){
        self.title = title
        self.url = url
    }
}
