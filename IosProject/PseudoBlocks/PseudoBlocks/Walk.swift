//
//  Walk.swift
//  PseudoBlocks
//
//  Created by fhict on 13/04/15.
//  Copyright (c) 2015 FHICT. All rights reserved.
//

import Foundation

class Walk: Block {
    
    var player:Player
    
    init(p:Player)
    {
        self.player = p
    }
    
    func start() {
        // todo
        switch player.derection{
        case WalkDirection.right:
            var tile = player.scene.getTile(1, row: 3)
            player.scene.movePlayer(tile!)

            break
        case WalkDirection.up:
            var tile = player.scene.getTile(1, row: 3)
            player.scene.movePlayer(tile!)
            
            break
        case WalkDirection.down:
            var tile = player.scene.getTile(1, row: 3)
            player.scene.movePlayer(tile!)
            
            break
        case WalkDirection.left:
            var tile = player.scene.getTile(1, row: 3)
            player.scene.movePlayer(tile!)
            
            break
        default:
            break
        }
        
            }
}