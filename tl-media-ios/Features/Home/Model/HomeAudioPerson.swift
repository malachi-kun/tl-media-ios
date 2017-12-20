//
//  HomeAudioPerson.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2017/12/20.
//  Copyright © 2017 Tabi-Labo. All rights reserved.
//

import UIKit


struct chatPerson{
    var name:String?
    var message:String?
    var personIcon:UIImage?
    
    init(name:String, message:String, personIcon:UIImage){
        self.name = name
        self.message = message
        self.personIcon = personIcon
    }
}

