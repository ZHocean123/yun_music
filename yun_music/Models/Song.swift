//
//  Song.swift
//  yun_music
//
//  Created by yang on 08/12/2017.
//  Copyright © 2017 ocean. All rights reserved.
//

import Foundation
import AVFoundation
import MediaPlayer

class Song {
    var url: URL?
    var metaData: MetaData?
    var item: AVPlayerItem?

    init() { }
    
    init?(path aPath: String, type: String = "mp3") {
        if let bundlePath = Bundle.main.path(forResource: aPath, ofType: type) {
            url = URL(fileURLWithPath: bundlePath)
        }
        if let url = url {
            self.item = AVPlayerItem(url: url)
            metaData = MetaData(withAVPlayerItem: item)
        }
    }
    
    init?(withAVPlayerItem item: AVPlayerItem) {
        guard let urlAsset = item.asset as? AVURLAsset else {
            return nil
        }
        metaData = MetaData(withAVPlayerItem: item)
        url = urlAsset.url
    }
}
