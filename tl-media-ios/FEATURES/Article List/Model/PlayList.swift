//
//  PlayList.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2018/02/28.
//  Copyright © 2018 Tabi-Labo. All rights reserved.
//

import UIKit

struct Playlist {
    var playList = [String:[PlayListItem]]()
    
    
    //creates playlist but if playlist exist, append latest playlist item.
    init(name:String, playListItem:PlayListItem) {
        if var pl = playList[name] {
            pl.append(playListItem)
            self.playList[name] = pl
        } else {
            createPlayList(name:name, playListItem:playListItem)
        }
    }
    
    //add playlistItem to playlist, if it doesn't exists, it'll create it.
    mutating func addPlayListItem(name:String, playListItem:PlayListItem){
        if let _ = playList[name] {
            self.playList[name]?.append(playListItem)
        } else {
            createPlayList(name:name, playListItem:playListItem)
        }
    }
    
    mutating func createPlayList(name:String, playListItem:PlayListItem){
        let playItemArray = [playListItem]
        self.playList[name] = playItemArray
    }
}
