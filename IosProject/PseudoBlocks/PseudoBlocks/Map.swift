//
//  Map.swift
//  PseudoBlocks
//
//  Created by fhict on 13/04/15.
//  Copyright (c) 2015 FHICT. All rights reserved.
//

import Foundation
import SpriteKit

class Map {
    
    let player :Player
    let tiles :NSArray
    
    init(p:Player,t:[Tile]){
        self.player = p
        self.tiles = t
    }
    
   static func generateMap(var mymap: [[Int]])-> [Tile]{
    var map = [Tile]()
        // 0 = grass
        // 1 = spawn
        // 2 = wall
        // 3 = water
        // 4 = dust
        // 5 = animal
    
        mymap = mymap.reverse()
        
        var tempSprite = MySprite(imageNamed: "GrassTile")
        var tiletype = TileType.grass
        
        var rowid = 0
        for row in mymap {
            
            var colid = 0
            for column in row {
                switch(column)
                {
                case 0:
                    tempSprite = MySprite(imageNamed: "GrassTile")
                    tiletype = TileType.grass
                    break;
                case 1:
                    tempSprite = MySprite(imageNamed: "GrassTile")
                    tiletype = TileType.spawn
                    break;
                case 2:
                    tempSprite = MySprite(imageNamed: "DarkTile")
                    tiletype = TileType.wall
                    break;
                case 3:
                    tempSprite = MySprite(imageNamed: "WaterTile")
                    tiletype = TileType.water
                    break;
                case 4:
                    tempSprite = MySprite(imageNamed: "DustTile")
                    tiletype = TileType.dust
                    break;
                case 5:
                    tempSprite = MySprite(imageNamed: "AnimalTile")
                    tiletype = TileType.animal
                    break;
                case 6:
                    tempSprite = MySprite(imageNamed: "EndTile")
                    tiletype = TileType.end
                    break;
                default:
                    tempSprite = MySprite(imageNamed: "GrassTile")
                    break;
                }
                var t = Tile(column: colid, row: rowid, tileType: tiletype, sprite: tempSprite)
                
                //var startPointWidth : CGFloat
                //var startPointHeigt : CGFloat
                
               // startPointHeigt = (size.height - t.sprite.size.height * 0.9) - t.sprite.size.height *  (CGFloat(NumRows) - CGFloat(rowid))
                //startPointWidth = size.width - t.sprite.size.width *  (CGFloat(NumColumns) - CGFloat(colid))
                
                // tile.sprite.position = CGPoint(x: startPointWidth, y: startPointHeigt)
                map.append(t)
                //addChild(tile.sprite)
                colid++
                
            }
            rowid++
        }
    return map;
    }
}