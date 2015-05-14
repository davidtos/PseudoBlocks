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
  
    var player:Player
    
    var levels :[[[Int]]]!
    
    init(p:Player)
    {
        self.player = p
        GenerateMaps()
        
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
        
        var newlvl = levelnummer + 1
        println(newlvl)
        if newlvl > 4
        {
            let endlevelScene = EndLevelScene(size: size)
            player.scene.view?.presentScene(endlevelScene, transition: reveal)

        }
        else{
            var Curlvl = levels[newlvl-1]
            
            var templevel = Level(map: Curlvl,nummer: newlvl)
            let gameScene = GameScene(size: size,level: templevel)
            player.scene.view?.presentScene(gameScene, transition: reveal)
        }
    }
    
    
    
    // 0 = grass
    // 1 = spawn
    // 2 = wall
    // 3 = water
    // 4 = dust
    // 5 = animal
    // 6 = end
    func GenerateMaps(){
        let lvl1 = [[2,2,2,2,2,2],
            [2,1,2,2,2,2],
            [2,0,2,2,2,2],
            [2,0,0,0,0,2],
            [2,2,2,2,6,2],
            [2,2,2,2,2,2]]
        
        let lvl2 = [[2,2,2,2,2,2],
            [2,2,2,2,1,2],
            [2,2,2,2,0,2],
            [2,0,5,0,0,2],
            [2,6,2,2,2,2],
            [2,2,2,2,2,2]]
        
        let lvl3 = [[2,2,2,2,2,2],
            [2,0,0,5,0,2],
            [2,4,2,2,0,2],
            [2,0,2,5,0,2],
            [2,1,2,6,2,2],
            [2,2,2,2,2,2]]
        
        let lvl4 = [[2,2,2,2,2,2],
                    [2,1,2,2,2,2],
                    [2,5,0,4,2,2],
                    [2,0,2,0,2,2],
                    [2,4,0,5,6,2],
                    [2,2,2,2,2,2]]
        
        levels = [lvl1,lvl2,lvl3,lvl4]
        
    }

}
