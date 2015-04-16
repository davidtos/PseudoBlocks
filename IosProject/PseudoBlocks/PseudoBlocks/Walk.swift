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
        println("c:\(player.tile.column) - r \(player.tile.row)")
        println(self.player.derection.description)
        // todo
        switch player.derection{
            
        case WalkDirection.right:
            var tile = player.scene.getTile(player.tile.column + 1, row: player.tile.row)
            player.scene.movePlayer(tile!)
            println("1c:\(player.tile.column) - r \(player.tile.row)")

            break
        case WalkDirection.up:
            var tile = player.scene.getTile(player.tile.column, row: player.tile.row + 1)
            player.scene.movePlayer(tile!)
             println("2c:\(player.tile.column) - r \(player.tile.row)")
            
            break
        case WalkDirection.down:
            var tile = player.scene.getTile(player.tile.column, row: player.tile.row - 1)
            player.scene.movePlayer(tile!)
             println("3c:\(player.tile.column) - r \(player.tile.row)")
            
            break
        case WalkDirection.left:
            var tile = player.scene.getTile(player.tile.column - 1, row: player.tile.row)
            player.scene.movePlayer(tile!)
             println("4c:\(player.tile.column) - r \(player.tile.row)")
            
            break
        default:
            break
        }
        
            }
}