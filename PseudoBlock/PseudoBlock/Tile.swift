//
//  Tile.swift
//  PseudoBlock
//
//  Created by fhict on 10/04/15.
//  Copyright (c) 2015 FHICT. All rights reserved.
//

import Foundation

class Tile {
    
    var x : Int
    var y : Int
    var item : Item?
    
    
    
    init(item : Item, X : Int,Y : Int){
        self.item = item
        self.x = X
        self.y = Y
    }
    
    init(X : Int,Y : Int){
        self.x = X
        self.y = Y
    }
    
    func PickUpItem() -> Bool{
        if(item == nil){
            return false
        }
        else{
            item = nil
            return true
        }
    }

}
