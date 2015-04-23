//
//  Project.swift
//  PseudoBlocks
//
//  Created by fhict on 13/04/15.
//  Copyright (c) 2015 FHICT. All rights reserved.
//

import Foundation

class Project {

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
    
    func ExecuteBlocks()
    {
        
    }
}
