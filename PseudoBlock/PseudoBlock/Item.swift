//
//  Item.swift
//  PseudoBlock
//
//  Created by fhict on 10/04/15.
//  Copyright (c) 2015 FHICT. All rights reserved.
//

import Foundation

class Item {
    
    var name = ""
    var icon = ""
    
    
    init(Name : String,Icon : String){
        self.name = Name
        self.icon = Icon
    }
    
    func getName()->String{
        return name;
    }
    
    func getIcon()->String{
        return icon;
    }
}