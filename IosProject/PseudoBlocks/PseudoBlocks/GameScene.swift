import SpriteKit
let NumColumns = 6
let NumRows = 6

struct PhysicsCategory {
    static let None      : UInt32 = 0
    static let All       : UInt32 = UInt32.max
    static let phyPlayer : UInt32 = 0b1
    static let phyTile   : UInt32 = 0b10
}

class GameScene: SKScene,SKPhysicsContactDelegate {
	//contains all tiles of the playground
    var map = [Tile]()
	//Node that holds the background image
    let background = SKSpriteNode(imageNamed: "ProgramBackground")
	//the run your code node
    let StartButtonSprite = SKSpriteNode(imageNamed: "RunButton")
	//the stop your code node
    let StopButtonSprite = SKSpriteNode(imageNamed: "StopButton")
    //the back button
    let BackButtonSprite = SKSpriteNode(imageNamed: "BackButton")
    
    
    
    let player = SKSpriteNode(imageNamed: "Player")
    let bStart = SKSpriteNode(imageNamed: "bStart")
    let bLoop = SKSpriteNode(imageNamed: "bLoop")
    let bDraai = SKSpriteNode(imageNamed: "bDraai")
    
    
    //Screen is set to the view
    override func didMoveToView(view: SKView) {
        //no gravity
        physicsWorld.gravity = CGVectorMake(0, 0)
        physicsWorld.contactDelegate = self
        
        background.anchorPoint = CGPointMake(0.5, 0.5)
        background.size.height = self.size.height
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        background.zPosition = -1
        addChild(background)
        
        CreateBlocks()
        
        addChild(player)
		//create a map
        generateMap()
        var tile = getTile(0, row: 3)
        if(tile != nil){
            player.position = tile!.sprite.position
			//set player to foreground
            player.zPosition = 1
        }
        SetButtons()
    }
    
    func CreateBlocks(){
        
        // temp positions for the buttons
        bStart.position = CGPoint(x: size.width * 0.1, y: size.height * 0.4)
        bLoop.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
        bDraai.position = CGPoint(x: size.width * 0.1, y: size.height * 0.6)
        
        bStart.physicsBody = SKPhysicsBody(rectangleOfSize: bStart.size)
        bStart.physicsBody?.dynamic = true // 2
        bStart.physicsBody!.categoryBitMask = PhysicsCategory.phyTile
        bStart.physicsBody?.contactTestBitMask = PhysicsCategory.phyTile // 4
        bStart.physicsBody?.collisionBitMask = PhysicsCategory.None
        bStart.physicsBody?.usesPreciseCollisionDetection = true
        bStart.physicsBody?.allowsRotation = false
        bStart.physicsBody?.angularVelocity = 0
        
        
        bLoop.physicsBody = SKPhysicsBody(rectangleOfSize: bLoop.size)
        bLoop.physicsBody?.dynamic = true // 2
        bLoop.physicsBody!.categoryBitMask = PhysicsCategory.phyTile
        bLoop.physicsBody?.contactTestBitMask = PhysicsCategory.phyTile // 4
        bLoop.physicsBody?.collisionBitMask = PhysicsCategory.None
        bLoop.physicsBody?.usesPreciseCollisionDetection = true
        bLoop.physicsBody?.allowsRotation = false
        bLoop.physicsBody?.angularVelocity = 0
        
        bDraai.physicsBody = SKPhysicsBody(rectangleOfSize: bLoop.size)
        bDraai.physicsBody?.dynamic = true // 2
        bDraai.physicsBody!.categoryBitMask = PhysicsCategory.phyTile
        bDraai.physicsBody?.contactTestBitMask = PhysicsCategory.phyTile // 4
        bDraai.physicsBody?.collisionBitMask = PhysicsCategory.None
        bDraai.physicsBody?.usesPreciseCollisionDetection = true
        bDraai.physicsBody?.allowsRotation = false
        bDraai.physicsBody?.angularVelocity = 0
        
        addChild(bStart)
        addChild(bLoop)
        addChild(bDraai)
    }
    
    func projectileDidCollideWithMonster(firstBody : SKSpriteNode, SecondBody : SKSpriteNode) {
        // Create joint between two objects
        
        firstBody.position.x = SecondBody.position.x
        firstBody.position.y = SecondBody.position.y - firstBody.size.height
        
        
        var myJoint = SKPhysicsJointPin.jointWithBodyA(SecondBody.physicsBody, bodyB: firstBody.physicsBody, anchor: CGPoint(x: CGRectGetMaxX(SecondBody.frame), y: CGRectGetMaxY(firstBody.frame)))
        
        var myJoint1 = SKPhysicsJointPin.jointWithBodyA(SecondBody.physicsBody, bodyB: firstBody.physicsBody, anchor: CGPoint(x: CGRectGetMinX(SecondBody.frame), y: CGRectGetMinY(firstBody.frame)))
        
        self.physicsWorld.addJoint(myJoint)
        self.physicsWorld.addJoint(myJoint1)
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
     
        // 1
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        // 2
        if ((firstBody.categoryBitMask == PhysicsCategory.phyTile) &&
            (secondBody.categoryBitMask == PhysicsCategory.phyTile)) {
                
                projectileDidCollideWithMonster(firstBody.node as! SKSpriteNode, SecondBody: secondBody.node as! SKSpriteNode)
        }
        
    }
    
	// sets all the buttons for this screen
    func SetButtons(){
        var startPointHeigt : CGFloat
        var startPointWidth : CGFloat
		
        //calculate position of the buttons
        startPointHeigt = size.height - (StartButtonSprite.size.height * 0.6)
        startPointWidth = size.width - StartButtonSprite.size.width * 2.5
		
        StopButtonSprite.position = CGPoint(x: startPointWidth, y: startPointHeigt)
        StartButtonSprite.position = CGPoint(x: (startPointWidth + StartButtonSprite.size.width * 1.4) , y: startPointHeigt)
        BackButtonSprite.position = CGPoint(x:(BackButtonSprite.size.width * 0.6) , y: startPointHeigt)
        
		addChild(BackButtonSprite)
        addChild(StartButtonSprite)
        addChild(StopButtonSprite)
    }
    
	// generates for now a default map for testing
    func generateMap(){
        for colmn in 0..<NumColumns{
            for row in 0..<NumRows{
                
                var tempSprite = SKSpriteNode(imageNamed: "GrassTile")
                var tile = Tile(column: colmn, row: row, tileType: TileType.Grass, sprite: tempSprite)
				
                var startPointWidth : CGFloat
                var startPointHeigt : CGFloat
                
                startPointHeigt = (size.height - tile.sprite.size.height * 0.9) - tile.sprite.size.height *  (CGFloat(NumRows) - CGFloat(row))
                startPointWidth = size.width - tile.sprite.size.width *  (CGFloat(NumColumns) - CGFloat(colmn))
                
                tile.sprite.position = CGPoint(x: startPointWidth, y: startPointHeigt)
                map.append(tile)
                addChild(tile.sprite)
            }
        }
    }
    //get a tile based on its position in the tabel
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
    
    // create a rondom number
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
     // create a rondom number
    func random(#min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
	//move a player from its current node to a given node with a random duration for its movement
    func movePlayer(tile: Tile){
        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
        var actionMove = SKAction.moveTo(tile.sprite.position , duration: NSTimeInterval(actualDuration))
        player.runAction(actionMove)
    }
    
	//catch a touch event and move a node 
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let touchedNode = nodeAtPoint(location)
            if(touchedNode == background){
                return;
            }
            if(touchedNode.physicsBody != nil){
                if(touchedNode.physicsBody!.categoryBitMask != PhysicsCategory.phyTile){
                    return;
                }
            }
            else
            {
                return;
            }
            
            touchedNode.position = location
        }
    }
    
    func StartPressed(){
        
    }
    
    func StopPressed()
    {
        
    }
    
    // catch a press on one of the nodes that are used as buttons
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = (touch as! UITouch).locationInNode(self)
            let touchedNode = nodeAtPoint(location)
            
            switch touchedNode{
            case StartButtonSprite:
                StartPressed()
            case StopButtonSprite:
                StopPressed()
            case BackButtonSprite:
                let menuScene = MenuScene(size: self.size)
                let reveal = SKTransition.doorsCloseHorizontalWithDuration(0.5)
                self.view?.presentScene(menuScene, transition: reveal)
            default:
                return
            }
        }
    }
}