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
        
        child.block?.start()
        if(child.ChildSprite != nil)
        {
            runBlocks(child.ChildSprite!)
        }
        
    }
    
    func ExecuteBlocks()
    {
        
    }
}
