//
//  PlayList.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2018/02/28.
//  Copyright © 2018 Tabi-Labo. All rights reserved.
//

import UIKit

struct PlayList {
    var pList = [String:[PlayListItem]]()
    
    
    //creates playlist but if playlist exist, append latest playlist item.
    init(name:String, item:PlayListItem) {
        if var pl = pList[name] {
            pl.append(item)
            self.pList[name] = pl
        } else {
            createPlayList(name:name, item:item)
        }
    }
    
    //add playlistItem to playlist, if it doesn't exists, it'll create it.
    mutating func addPlayListItem(name:String, item:PlayListItem){
        if let _ = pList[name] {
            self.pList[name]?.append(item)
        } else {
            createPlayList(name:name, item:item)
        }
    }
    
    mutating func createPlayList(name:String, item:PlayListItem){
        let playItemArray = [item]
        self.pList[name] = playItemArray
    }
}
