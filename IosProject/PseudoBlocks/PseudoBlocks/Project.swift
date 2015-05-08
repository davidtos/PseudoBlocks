//
//  Project.swift
//  PseudoBlocks
//
//  Created by fhict on 13/04/15.
//  Copyright (c) 2015 FHICT. All rights reserved.
//
import Foundation
import SpriteKit


class Project {
let reveal = SKTransition.doorsOpenHorizontalWithDuration(0.5)
    // var : player
    var player:Player
    
    init(p:Player)
    {
        self.player = p
        
    }

    
    
    func runBlocks(child:MySprite){
        // start uitvoeren van blok
        child.block?.start()
        if(child.ChildSprite != nil)
        {
            if(child.block == nil || child.ChildSprite?.block is Turn)
            {
                // wacht niet
                self.runBlocks(child.ChildSprite!)
            }
            else
            {
                // wacht 3 seconde met door gaan
                let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(3 * Double(NSEC_PER_SEC)))
                dispatch_after(delayTime, dispatch_get_main_queue()) {
                    println("next block executed")
                    
                    self.runBlocks(child.ChildSprite!) // << recursie
                }
            }
        }
    }
    
    func ShowNextLevel(size: CGSize,levelnummer : Int){
        
        if levelnummer + 1 > 4
        {
          // show the end screen
        }
        else{
            var templevel = Level(map: [
                [2,0,2,2,0,3],
                [2,0,2,2,0,0],
                [2,5,2,2,2,2],
                [2,1,4,4,0,2],
                [2,2,2,2,3,2],
                [2,2,2,2,0,2]],nummer: levelnummer + 1)
            let gameScene = GameScene(size: size,level: templevel)
            player.scene.view?.presentScene(gameScene, transition: reveal)
        }
    }
    
    func ExecuteBlocks()
    {
        
    }
}
