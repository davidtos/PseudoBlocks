//
//  Tiles.swift
//  PseudoBlocks
//
//  Created by fhict on 13/04/15.
//  Copyright (c) 2015 FHICT. All rights reserved.
//

import Foundation

class Tiles {
    
    let item :Item?
    
    init(item: Item)
    {
        self.item = item
    }
    
    init()
    {
        item = nil
    }
}