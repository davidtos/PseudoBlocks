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
    
    var description : String {
        get {
            switch(self) {
            case up:
                return "up"
            case down:
                return "down"
            case right:
                return "right"
            case left:
                return "left"
            default:
                return ""
            }
        }
    }
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
    
    func setDirection(wd:WalkDirection)
    {
        self.derection = wd
    }
    
}