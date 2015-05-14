import SpriteKit
//the kinds of tiles that are available
enum TileType: Int {
    case grass = 1,spawn,wall,water,dust,animal,end
}

class Tile {
    var column: Int
    var row: Int
    let tileType: TileType
    var sprite: SKSpriteNode
    
    init(column: Int, row: Int, tileType: TileType,sprite: SKSpriteNode) {
        self.column = column
        self.row = row
        self.tileType = tileType
        self.sprite = sprite
    }
}