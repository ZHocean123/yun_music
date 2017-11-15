//
//  PlayEngine.swift
//  yun_music
//
//  Created by yang on 15/11/2017.
//  Copyright © 2017 ocean. All rights reserved.
//

import Foundation

public struct PlayItem {
    var id: String
    var img: String
}

public enum PlayMode {
    case order
    case random
    case circle
}

public class PlayEngine {
    public var list: [PlayItem] = []
    public var playMode: PlayMode = .order

    public func play() {

    }
    public func pause() {

    }
}
