import SpriteKit
//the kinds of tiles that are available
enum TileType: Int {
    case Unknown = 0, Grass, Dark
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