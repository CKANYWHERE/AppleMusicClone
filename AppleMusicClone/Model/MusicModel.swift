//
//  MusicModel.swift
//  AppleMusicClone
//
//  Created by 민창경 on 2020/11/25.
//

import Foundation

struct MusicModel {
    var author:String?
    var song:String?
    var img:String?
    
    init(author:String, song:String, img:String) {
        self.author = author
        self.song = song
        self.img = img
    }
    
}
