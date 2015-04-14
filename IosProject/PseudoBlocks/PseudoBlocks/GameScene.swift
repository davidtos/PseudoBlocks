import SpriteKit
let NumColumns = 6
let NumRows = 6

struct PhysicsCategory {
    static let None      : UInt32 = 0
    static let All       : UInt32 = UInt32.max
    static let phyPlayer    : UInt32 = 0b1       // 1
    static let phyTile      : UInt32 = 0b10     //2
}

class GameScene: SKScene,SKPhysicsContactDelegate {
    var map = [Tile]()
    
    // 1
    let player = SKSpriteNode(imageNamed: "Player")
    let bStart = SKSpriteNode(imageNamed: "bStart")
    let bLoop = SKSpriteNode(imageNamed: "bLoop")
    let bDraai = SKSpriteNode(imageNamed: "bDraai")
    
    override func didMoveToView(view: SKView) {
        
        physicsWorld.gravity = CGVectorMake(0, 0)
        physicsWorld.contactDelegate = self
        
        // 2
        backgroundColor = SKColor.whiteColor()
        // 3
        player.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
        // 4
        
        bStart.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
        bLoop.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
        bDraai.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
        
        addChild(bStart)
        addChild(bLoop)
        addChild(bDraai)
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
                
                var tempSprite = SKSpriteNode(imageNamed: "GrassTile")
                tempSprite.physicsBody = SKPhysicsBody(rectangleOfSize: tempSprite.size) // 1
                tempSprite.physicsBody?.dynamic = true // 2
                tempSprite.physicsBody!.categoryBitMask = PhysicsCategory.phyTile
                
                var tile = Tile(column: colmn, row: row, cookieType: TileType.Grass, sprite: tempSprite)
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
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let touchedNode = nodeAtPoint(location)
            if(touchedNode.physicsBody != nil){
                if(touchedNode.physicsBody!.categoryBitMask != PhysicsCategory.phyPlayer){
                    return;
                }
            }
            touchedNode.position = location
        }
    }
    
}