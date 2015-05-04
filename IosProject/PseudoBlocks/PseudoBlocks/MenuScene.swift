import SpriteKit

class MenuScene: SKScene,SKPhysicsContactDelegate {
    
    let background = SKSpriteNode(imageNamed: "StartScreen")
    let PlayButton = SKSpriteNode(imageNamed: "PlayButton")
    let ShareButton = SKSpriteNode(imageNamed: "ShareButton")
    let LevelsButton = SKSpriteNode(imageNamed: "LevelsButton")
    var map = [Tile]()
	let reveal = SKTransition.doorsOpenHorizontalWithDuration(0.5)
	
    
	
    override func didMoveToView(view: SKView) {
        physicsWorld.gravity = CGVectorMake(0, 0)
        physicsWorld.contactDelegate = self
        
        background.anchorPoint = CGPointMake(0.5, 0.5)
        background.size.height = self.size.height
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        addChild(background)
        setButtons()

    }
    // set all the buttons used in this scene
    func setButtons(){
        PlayButton.position = CGPoint(x: size.width * 0.5, y: size.height * 0.44)
        ShareButton.position = CGPoint(x: (PlayButton.position.x + (ShareButton.size.width * 1.1)), y: size.height * 0.44)
        LevelsButton.position = CGPoint(x: (PlayButton.position.x - (LevelsButton.size.width * 1.1)), y: size.height * 0.44)
        
        addChild(LevelsButton)
        addChild(ShareButton)
        addChild(PlayButton)
    }
    // catch a press on one of the nodes that are used as buttons
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = (touch as! UITouch).locationInNode(self)
            let touchedNode = nodeAtPoint(location)
			
            if PlayButton == touchedNode{
                generateMap()
                let gameScene = GameScene(size: self.size,map: map)
                
                
                self.view?.presentScene(gameScene, transition: reveal)
                
            }
            
        }
        
    }
    
    // generates for now a default map for testing
    func generateMap(){
        // 0 = grass
        // 1 = spawn
        // 2 = wall
        // 3 = water
        // 4 = dust
        // 5 = animal
        var map: Int[][] = [[2,1,2,2,2,2],
                            [2,0,2,2,2,2],
                            [2,0,0,0,0,2],
                            [2,2,2,2,3,2],
                            [2,2,2,2,3,2],
                            [2,2,2,2,0,2]]
        map = map.reverse()

        var rowid = 0
        for row in map {
            
            var colid = 0
            for column in row {
                
                var tempSprite = MySprite(imageNamed: "GrassTile")
                var tile = Tile(column: colmn, row: row, tileType: TileType.Grass, sprite: tempSprite)
                
                var startPointWidth : CGFloat
                var startPointHeigt : CGFloat
                
                startPointHeigt = (size.height - tile.sprite.size.height * 0.9) - tile.sprite.size.height *  (CGFloat(NumRows) - CGFloat(row))
                startPointWidth = size.width - tile.sprite.size.width *  (CGFloat(NumColumns) - CGFloat(colmn))
                
                // tile.sprite.position = CGPoint(x: startPointWidth, y: startPointHeigt)
                map.append(tile)
                //addChild(tile.sprite)
            }
        }
    }
}