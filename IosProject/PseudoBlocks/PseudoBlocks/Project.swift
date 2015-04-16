//
//  Project.swift
//  PseudoBlocks
//
//  Created by fhict on 13/04/15.
//  Copyright (c) 2015 FHICT. All rights reserved.
//

import Foundation

class Project {
    
    // list of block protocol objects
    //var blocks :[Block]
    
    // var : player
    var player:Player
    
    // para scene
    init(p:Player)
    {
        //self.blocks = [Block]()
        self.player = p
        
    }
/*
    // adds a newblock to the list
    func AddBlock(block: Block)
    {
        blocks.append(block)
    }
    
    func removeBlock(block: Block)
    {
        /*
        // check if block exists in list
        if contains(blocks,Block)
            // check is object is removed if true object is returned
            if let removed = blocks. .remove(Block){
                println("\(removed) is now removed from blocks")
            } else {
                println("block not removed")
            }
        
        }else {
            println("block not found")
        }*/
    }
    */
    func ExecuteBlocks(runBlocks: [Block])
    {
        
    }
}
