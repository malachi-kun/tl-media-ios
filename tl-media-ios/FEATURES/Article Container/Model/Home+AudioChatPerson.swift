//
//  HomeAudioPerson.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2017/12/20.
//  Copyright © 2017 Tabi-Labo. All rights reserved.
//

import UIKit

struct chatPerson{
    var id:String?
    var name:String?
    var personIcon:UIImage?
    
    init(id:String, name:String, personIcon:UIImage){
        self.id = id
        self.name = name
        self.personIcon = personIcon
    }
}

