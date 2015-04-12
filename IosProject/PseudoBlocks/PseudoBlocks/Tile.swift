import SpriteKit

enum TileType: Int {
    case Unknown = 0, Grass, Dark
}

class Tile {
    var column: Int
    var row: Int
    let cookieType: TileType
    var sprite: SKSpriteNode
    
    init(column: Int, row: Int, cookieType: TileType,sprite: SKSpriteNode) {
        self.column = column
        self.row = row
        self.cookieType = cookieType
        self.sprite = sprite
    }
}