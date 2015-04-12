import SpriteKit
let NumColumns = 6
let NumRows = 6


class GameScene: SKScene {
        var map = [Tile]()
    
    // 1
    let player = SKSpriteNode(imageNamed: "Player")
    
    override func didMoveToView(view: SKView) {
        // 2
        backgroundColor = SKColor.whiteColor()
        // 3
        player.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
        // 4
        addChild(player)
        generateMap()
        var tile = getTile(0, row: 3)
        if(tile != nil){
            player.position = tile!.sprite.position
            player.zPosition = 1
        }
        tile = getTile(5, row: 5)
        movePlayer(tile!)
    }
    
    func generateMap(){
        for colmn in 0..<NumColumns{
            for row in 0..<NumRows{
                var tile = Tile(column: colmn, row: row, cookieType: TileType.Grass, sprite: SKSpriteNode(imageNamed: "GrassTile"))
                var startPointWidth : CGFloat
                var startPointHeigt : CGFloat
                
                startPointHeigt = size.height - tile.sprite.size.height *  (CGFloat(NumRows) - CGFloat(row))
                startPointWidth = size.width - tile.sprite.size.width *  (CGFloat(NumColumns) - CGFloat(colmn))
                
                tile.sprite.position = CGPoint(x: startPointWidth, y: startPointHeigt)
                map.append(tile)
                addChild(tile.sprite)
            }
        }
    }
    
    func getTile(column: Int, row: Int) -> Tile?{
        var tile = Tile?();
        for tile in map {
            if(tile.row == row){
                if(tile.column == column){
                    return tile;
                }
            }
        }
        return nil;
    }
    
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(#min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    func movePlayer(tile: Tile){
        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
        var actionMove = SKAction.moveTo(tile.sprite.position , duration: NSTimeInterval(actualDuration))
        player.runAction(actionMove)
    }
    
}