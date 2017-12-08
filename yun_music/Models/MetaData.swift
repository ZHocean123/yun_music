//
//  MetaData.swift
//  yun_music
//
//  Created by yang on 08/12/2017.
//  Copyright © 2017 ocean. All rights reserved.
//

import Foundation
import AVFoundation
import MediaPlayer

class MetaData {
    var title: String? = "Unknown"
    var creationDate = Date()
    var artwork: UIImage? = #imageLiteral(resourceName: "cm2_default_cover_play")
    var albumName: String? = "Unknown"
    var artist: String? = "Unknown"
    var duration: Float64 = 0
    
    init?(withAVPlayerItem item: AVPlayerItem?) {
        
        guard let playerItem = item else { return }
        let commonMetadata = playerItem.asset.commonMetadata
        duration = CMTimeGetSeconds(playerItem.asset.duration)
        
        for metadataItem in commonMetadata {
            switch metadataItem.commonKey?.rawValue ?? "" {
            case "title":
                title = metadataItem.stringValue
            case "creationDate":
                break
            case "artwork":
                if let imageData = metadataItem.value as? Data {
                    artwork = UIImage(data: imageData)
                }
            case "albumName":
                albumName = metadataItem.stringValue
            case "artist":
                artist = metadataItem.stringValue
            default: break
            }
        }
    }
    
    init?(withMPMediaItem item: MPMediaItem?) {
        guard let playerItem = item else { return }
        title = playerItem.title
        artwork = playerItem.artwork?.image(at: CGSize(width: 100, height: 100))
        albumName = playerItem.albumTitle
        artist = playerItem.artist
        duration = playerItem.playbackDuration
    }
}
