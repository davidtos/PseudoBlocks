//
//  Map.swift
//  PseudoBlocks
//
//  Created by fhict on 13/04/15.
//  Copyright (c) 2015 FHICT. All rights reserved.
//

import Foundation

class Map {
    
    let player = Player
    let tiles = [Tiles]()
    
    init(Player p, Tile t){
        self.player = p
        self.tiles = t
    }
}