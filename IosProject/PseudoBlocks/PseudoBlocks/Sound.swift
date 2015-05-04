//
//  Sound.swift
//  PseudoBlocks
//
//  Created by fhict on 13/04/15.
//  Copyright (c) 2015 FHICT. All rights reserved.
//

import Foundation
import AVFoundation
// uses musicplayer to execute sound to wake up enemies in front of teh player

class Sound: Block {
    var player:Player
    
    init(p:Player)
    {
        self.player = p
    }
    
    var AudioURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("01-intro", ofType: "mp3")!)
    
    var AudioPlayer = AVAudioPlayer()
    
    func start() {
        AudioPlayer = AVAudioPlayer(contentsOfURL: AudioURL, error: nil)
        self.PlaySound()
         walk()
        let delayTime = dispatch_time(DISPATCH_TIME_NOW,
            Int64(4 * Double(NSEC_PER_SEC)))
        
       
        
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            println("test")
            self.AudioPlayer.stop()
        }
    }
    
    func walk()
    {
        
        var tile :Tile
        
        switch player.derection{
            
        case WalkDirection.right:
            tile = player.scene.getTile(player.tile.column + 1, row: player.tile.row)!
            if(tile.tileType == TileType.animal){
                player.scene.movePlayer(tile)
            }
            else {
                tile = player.scene.getTile(player.tile.column, row: player.tile.row)!
            }
            //println("1c:\(player.tile.column) - r \(player.tile.row)")
            
            break
        case WalkDirection.up:
            tile = player.scene.getTile(player.tile.column, row: player.tile.row + 1)!
            if(tile.tileType == TileType.animal){
                player.scene.movePlayer(tile)
            }
            else {
                tile = player.scene.getTile(player.tile.column, row: player.tile.row)!
            }
            // println("2c:\(player.tile.column) - r \(player.tile.row)")
            
            break
        case WalkDirection.down:
            tile = player.scene.getTile(player.tile.column, row: player.tile.row - 1)!
            if(tile.tileType == TileType.animal){
                player.scene.movePlayer(tile)
            }
            else {
                tile = player.scene.getTile(player.tile.column, row: player.tile.row)!
            }
            // println("3c:\(player.tile.column) - r \(player.tile.row)")
            
            break
        case WalkDirection.left:
            tile = player.scene.getTile(player.tile.column - 1, row: player.tile.row)!
            if(tile.tileType == TileType.animal){
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

    func PlaySound(){
        AudioPlayer.play()
    }
    
    func StopSound()
    {
        AudioPlayer.stop()
        AudioPlayer.currentTime = 0;
    }
}