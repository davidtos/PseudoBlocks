//
//  Turn.swift
//  PseudoBlocks
//
//  Created by fhict on 13/04/15.
//  Copyright (c) 2015 FHICT. All rights reserved.
//

import Foundation


class Turn: Block {
    
    var player:Player
    var nextWD:WalkDirection
    
    init(p:Player,newWalkingDirection:WalkDirection)
    {
        self.player = p
        self.nextWD = newWalkingDirection
    }
    
    func start() {
        println("----\(self.nextWD.description)")
        self.player.setDirection(self.nextWD)
        println("----\(self.nextWD.description)")
    }
}