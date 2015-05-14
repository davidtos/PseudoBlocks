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
       // println("c:\(player.tile.column) - r \(player.tile.row)")
        
        var tile :Tile
        
        switch player.derection{
            
        case WalkDirection.right:
            tile = player.scene.getTile(player.tile.column + 1, row: player.tile.row)!
            if(tile.tileType == TileType.grass || tile.tileType == TileType.end){
            player.scene.movePlayer(tile)
            }
            else {
                tile = player.scene.getTile(player.tile.column, row: player.tile.row)!
            }
            //println("1c:\(player.tile.column) - r \(player.tile.row)")

            break
        case WalkDirection.up:
            tile = player.scene.getTile(player.tile.column, row: player.tile.row + 1)!
            if(tile.tileType == TileType.grass || tile.tileType == TileType.end){
            player.scene.movePlayer(tile)
            }
            else {
                tile = player.scene.getTile(player.tile.column, row: player.tile.row)!
            }
            // println("2c:\(player.tile.column) - r \(player.tile.row)")
            
            break
        case WalkDirection.down:
            tile = player.scene.getTile(player.tile.column, row: player.tile.row - 1)!
            if(tile.tileType == TileType.grass || tile.tileType == TileType.end){
            player.scene.movePlayer(tile)
            }
            else {
                tile = player.scene.getTile(player.tile.column, row: player.tile.row)!
            }
            // println("3c:\(player.tile.column) - r \(player.tile.row)")
            
            break
        case WalkDirection.left:
            tile = player.scene.getTile(player.tile.column - 1, row: player.tile.row)!
            if(tile.tileType == TileType.grass || tile.tileType == TileType.end){
            player.scene.movePlayer(tile)
            }
            else {
                tile = player.scene.getTile(player.tile.column, row: player.tile.row)!
            }
            // println("4c:\(player.tile.column) - r \(player.tile.row)")
            
            break
        default:
            tile = player.tile
            break
        }
        println("x:\(tile.column) y:\(tile.row)")
        player.tile = tile
    }
    
        
}