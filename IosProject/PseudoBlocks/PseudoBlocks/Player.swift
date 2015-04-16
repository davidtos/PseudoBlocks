//
//  Player.swift
//  PseudoBlocks
//
//  Created by fhict on 13/04/15.
//  Copyright (c) 2015 FHICT. All rights reserved.
//

import Foundation

enum WalkDirection: Int {
    case Unknown = 0, up,down,right,left
}


class Player {
    
    var scene:GameScene
    var tile: Tile
    var derection:WalkDirection
    
    
    init(sc:GameScene,t:Tile)
    {
        self.scene = sc
        self.tile = t
        self.derection = WalkDirection.right
    }
    
}