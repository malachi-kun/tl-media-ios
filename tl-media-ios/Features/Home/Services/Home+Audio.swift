//
//  Home+Audio.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2017/12/15.
//  Copyright © 2017 Tabi-Labo. All rights reserved.
//

import Foundation
import MediaPlayer

class HomeAudio {
    var avPlayer: AVPlayer?
    
    static let shared = HomeAudio(fileURL:"http://techslides.com/demos/samples/sample.mp3")
    //static let shared = HomeAudio()
    
    init() {
        avPlayer = AVPlayer()
    }
    
    init(fileURL:String){
        guard let url = URL(string: fileURL) else {return}
        self.avPlayer = AVPlayer(url: url)
        setPlayingScreen(fileURL:fileURL)
        playAudio()
    }
    
    func playStream(fileURL: String) {
        guard let url = URL(string: fileURL) else {return}
        
        avPlayer = AVPlayer(url: url)
        avPlayer?.play()
        
        setPlayingScreen(fileURL:fileURL)
    }
    
    func playAudio(){
        if (avPlayer?.rate == 0 && avPlayer?.error == nil) {
            avPlayer?.play()
        }
    }
    
    func pauseAudio(){
        let floatZero = Float(0)
        if ((avPlayer?.rate)! > floatZero && avPlayer?.error == nil) {
            avPlayer?.pause()
        }
    }
    
    func resetAudio(){
        avPlayer?.seek(to: kCMTimeZero)
    }
    
    func setPlayingScreen(fileURL: String){
        let urlArray = fileURL.components(separatedBy: "/")
        let name = urlArray.last
        
        let songInfo = [
            MPMediaItemPropertyTitle:name,
            MPMediaItemPropertyArtist: "Learning Radio"
        ]
        MPNowPlayingInfoCenter.default().nowPlayingInfo = songInfo as Any as? [String : Any]
    }
}
