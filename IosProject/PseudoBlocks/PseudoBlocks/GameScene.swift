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
    let background = MySprite(imageNamed: "ProgramBackground")
	//the run your code node
    let StartButtonSprite = MySprite(imageNamed: "RunButton")
	//the stop your code node
    let StopButtonSprite = MySprite(imageNamed: "StopButton")
    //the back button
    let BackButtonSprite = MySprite(imageNamed: "BackButton")

    let player = MySprite(imageNamed: "Player")
    let bStart = MySprite(imageNamed: "Start")
    var loopFloat = CGPoint()
    var draaiFloat = CGPoint()
    var GeluidFloat = CGPoint()
    var spawnpoint = CGPoint()
    
    var admin: Project?
    
    init(size: CGSize,map : [Tile])
    {
        super.init(size: size)
        self.map = map;
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //Screen is set to the view
    override func didMoveToView(view: SKView) {
        bStart.DangerZone = true;
        //no gravity
        // create administartion > with scene (this)
        physicsWorld.gravity = CGVectorMake(0, 0)
        physicsWorld.contactDelegate = self
        
        background.anchorPoint = CGPointMake(0.5, 0.5)
        background.size.height = self.size.height
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        background.zPosition = -1
        addChild(background)
        DrawMap()
        var p = Player(sc: self,t: self.getTile(Int(spawnpoint.x), row:Int(spawnpoint.y))!)
        addChild(player)
        //create a map
        
        var tile = getTile(Int(spawnpoint.x), row:Int(spawnpoint.y))
        if(tile != nil){
            player.position = tile!.sprite.position
            //set player to foreground
            player.zPosition = 1
        }
        self.admin = Project(p: p)
        CreateBlocks()
        SetPseudoBlocks(0)
        SetButtons()
    }
    
    func SetPseudoBlocks(nummer : Int){
        
        if(1 == nummer){
            var tempBlock:MySprite
            tempBlock = MySprite(imageNamed: "Loop")
            tempBlock.block = Walk(p: admin!.player)
            tempBlock.position = CGPoint(x: size.width * 0.74 , y: size.height * CGFloat(2) * 0.06 )
            SetPhysicsPseudoBlocks(tempBlock)
            addChild(tempBlock)
        }
        else if(2 == nummer){
            var tempBlock:MySprite
            tempBlock = MySprite(imageNamed: "DraaiUp")
            tempBlock.block = Turn(p: admin!.player, newWalkingDirection: WalkDirection.up)
            tempBlock.position = CGPoint(x: size.width * 0.74 , y: size.height * CGFloat(3) * 0.06 )
            SetPhysicsPseudoBlocks(tempBlock)
            addChild(tempBlock)
        }
       else if(3 == nummer){
            
            var tempBlock:MySprite
            tempBlock = MySprite(imageNamed: "DraaiDown")
            tempBlock.block = Turn(p: admin!.player, newWalkingDirection: WalkDirection.down)
            tempBlock.position = CGPoint(x: size.width * 0.74 , y: size.height * CGFloat(4) * 0.06 )
            SetPhysicsPseudoBlocks(tempBlock)
            addChild(tempBlock)
        }
       else if(4 == nummer)
        {
            var tempBlock:MySprite
            
            tempBlock = MySprite(imageNamed: "DraaiRight")
            tempBlock.block = Turn(p: admin!.player, newWalkingDirection: WalkDirection.right)
            tempBlock.position = CGPoint(x: size.width * 0.74 , y: size.height * CGFloat(5) * 0.06 )
            SetPhysicsPseudoBlocks(tempBlock)
            addChild(tempBlock)
        }
        else if(5 == nummer)
        {
            var tempBlock:MySprite
            tempBlock = MySprite(imageNamed: "DraaiLeft")
            tempBlock.block = Turn(p: admin!.player, newWalkingDirection: WalkDirection.left)
            tempBlock.position = CGPoint(x: size.width * 0.74 , y: size.height * CGFloat(6) * 0.06 )
            SetPhysicsPseudoBlocks(tempBlock)
            addChild(tempBlock)
        }
        else if(6 == nummer){
            var tempBlock:MySprite
            tempBlock = MySprite(imageNamed: "Geluid")
            tempBlock.block =  Sound(p: admin!.player)
            tempBlock.position = CGPoint(x: size.width * 0.9 , y: size.height * CGFloat(6) * 0.06 )
            SetPhysicsPseudoBlocks(tempBlock)
            addChild(tempBlock)
        }
        else if(7 == nummer){
            var tempBlock:MySprite
            tempBlock = MySprite(imageNamed: "Blazen")
            tempBlock.block =  Blow(p: admin!.player)
            tempBlock.position = loopFloat
            SetPhysicsPseudoBlocks(tempBlock)
            addChild(tempBlock)
        }
        else{
            for amount in 0...7{
                var tempBlock:MySprite
                
                if(amount == 0)
                {
                    tempBlock = MySprite(imageNamed: "Loop")
                    tempBlock.block = Walk(p: admin!.player)
                    loopFloat = CGPoint(x: size.width * 0.9 , y: size.height * CGFloat(amount + 4) * 0.06 )
                    tempBlock.position = loopFloat
                }
                else if(amount == 1)
                {
                    tempBlock = MySprite(imageNamed: "Geluid")
                    tempBlock.block = Sound(p: admin!.player)
                        GeluidFloat = CGPoint(x: size.width * 0.9 , y: size.height * CGFloat(amount + 4) * 0.06 )
                    tempBlock.position = GeluidFloat
                }
                else if(amount == 2)
                {
                    tempBlock = MySprite(imageNamed: "DraaiDown")
                    tempBlock.block = Turn(p: admin!.player, newWalkingDirection: WalkDirection.down)
                   draaiFloat = CGPoint(x: size.width * 0.9 , y: size.height * CGFloat(amount + 4) * 0.06 )
                    tempBlock.position = draaiFloat
                }
                else if(amount == 3)
                {
                    tempBlock = MySprite(imageNamed: "DraaiUp")
                    tempBlock.block = Turn(p: admin!.player, newWalkingDirection: WalkDirection.up)
                    draaiFloat = CGPoint(x: size.width * 0.9 , y: size.height * CGFloat(amount + 4) * 0.06 )
                    tempBlock.position = draaiFloat
                }
                else if(amount == 4)
                {
                    tempBlock = MySprite(imageNamed: "DraaiLeft")
                    tempBlock.block = Turn(p: admin!.player, newWalkingDirection: WalkDirection.left)
                    draaiFloat = CGPoint(x: size.width * 0.9 , y: size.height * CGFloat(amount + 4) * 0.06 )
                    tempBlock.position = draaiFloat
                }
                else if(amount == 5)
                {
                    tempBlock = MySprite(imageNamed: "DraaiRight")
                    tempBlock.block = Turn(p: admin!.player, newWalkingDirection: WalkDirection.right)
                    draaiFloat = CGPoint(x: size.width * 0.9 , y: size.height * CGFloat(amount + 4) * 0.06 )
                    tempBlock.position = draaiFloat
                }
                else if(amount == 6)
                {
                    tempBlock = MySprite(imageNamed: "Blazen")
                    tempBlock.block = Blow(p: admin!.player)
                    draaiFloat = CGPoint(x: size.width * 0.9 , y: size.height * CGFloat(amount + 4) * 0.06 )
                    tempBlock.position = draaiFloat
                }
                else
                {
                    tempBlock = MySprite()
                    //tempBlock.block = Walk(p: admin!.player)
                    //loopFloat = CGPoint(x: size.width * 0.9 , y: size.height * CGFloat(amount + 4) * 0.06 )
                    //tempBlock.position = loopFloat
                }
               
                
                SetPhysicsPseudoBlocks(tempBlock)
                var tempfloat = size.height * CGFloat(amount + 1)
                
                tempBlock.position = CGPoint(x: size.width * 0.9 , y: tempfloat * 0.06 )
                addChild(tempBlock)
            }
        }
    }
    
    
    func CreateBlocks(){
        // temp positions for the buttons
        bStart.position = CGPoint(x: size.width * 0.1, y: size.height * 0.4)
        SetPhysicsPseudoBlocks(bStart)
        addChild(bStart)        
    }
    
    func SetPhysicsPseudoBlocks(tb : MySprite)
    {
        tb.physicsBody = SKPhysicsBody(rectangleOfSize: bStart.size)
        tb.physicsBody?.dynamic = true // 2
        tb.physicsBody!.categoryBitMask = PhysicsCategory.phyTile
        tb.physicsBody?.contactTestBitMask = PhysicsCategory.phyTile // 4
        tb.physicsBody?.collisionBitMask = PhysicsCategory.None
        tb.physicsBody?.usesPreciseCollisionDetection = true
        tb.physicsBody?.allowsRotation = false
        tb.physicsBody?.angularVelocity = 0
        
    }
    
    func projectileDidCollideWithMonster(firstBody : MySprite, SecondBody : MySprite) {
        // Create joint between two objects
        if(!firstBody.DangerZone || !SecondBody.DangerZone)
        {
            return;
        }
        
        firstBody.position.x = SecondBody.position.x
        firstBody.position.y = SecondBody.position.y - firstBody.size.height
        
        var myJoint = SKPhysicsJointPin.jointWithBodyA(firstBody.physicsBody, bodyB: SecondBody.physicsBody, anchor: CGPoint(x: CGRectGetMaxX(SecondBody.frame), y: CGRectGetMaxY(firstBody.frame)))
        
        var myJoint1 = SKPhysicsJointPin.jointWithBodyA(firstBody.physicsBody, bodyB: SecondBody.physicsBody, anchor: CGPoint(x: CGRectGetMinX(SecondBody.frame), y: CGRectGetMinY(firstBody.frame)))
        
        firstBody.MyJoints.append(myJoint)
        firstBody.MyJoints.append(myJoint1)
        self.physicsWorld.addJoint(myJoint)
        self.physicsWorld.addJoint(myJoint1)

        firstBody.ParentSprite = SecondBody
        SecondBody.ChildSprite = firstBody
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
     
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
  
        firstBody = contact.bodyB
        secondBody = contact.bodyA
        
        var temp1Sprite = firstBody.node as! MySprite
        var temp2Sprite = secondBody.node as! MySprite
        
        if(temp1Sprite.ParentSprite != nil && temp1Sprite.block != nil){
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else if(temp1Sprite.ParentSprite != nil){
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if ((firstBody.categoryBitMask == PhysicsCategory.phyTile) &&
            (secondBody.categoryBitMask == PhysicsCategory.phyTile)) {
                
                projectileDidCollideWithMonster(firstBody.node as! MySprite, SecondBody: secondBody.node as! MySprite)
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
    
    
    func DrawMap(){
        for tile in map{
            var startPointWidth : CGFloat
            var startPointHeigt : CGFloat
            
            startPointHeigt = (size.height - tile.sprite.size.height * 0.9) - tile.sprite.size.height *  (CGFloat(NumRows) - CGFloat(tile.row))
            startPointWidth = size.width - tile.sprite.size.width *  (CGFloat(NumColumns) - CGFloat(tile.column))
            
            tile.sprite.position = CGPoint(x: startPointWidth, y: startPointHeigt)
            map.append(tile)
            addChild(tile.sprite)
            
            if(tile.tileType == TileType.spawn){
                 spawnpoint = CGPoint(x:tile.column,y:tile.row)
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
            var node = touchedNode as! MySprite
            
            if location.x < size.width / 1.6 {
                
                
                if(node.block is Walk && node.DangerZone == false){
                    SetPseudoBlocks(1)
                }
                else if(node.block is Turn && node.DangerZone == false){
                    println((node.block as! Turn).nextWD.description)
                    if (node.block as! Turn).nextWD.description == WalkDirection.up.description
                    {
                        println("2")
                        SetPseudoBlocks(2)
                    }
                    else if (node.block as! Turn).nextWD.description == WalkDirection.down.description
                    {
                        println("3")
                        SetPseudoBlocks(3)
                    }
                    else if (node.block as! Turn).nextWD.description == WalkDirection.right.description
                    {
                        println("4")
                     SetPseudoBlocks(4)
                    }
                    else if (node.block as! Turn).nextWD.description == WalkDirection.left.description
                    {
                        println("5")
                        SetPseudoBlocks(5)
                    }
                    else
                    {
                        SetPseudoBlocks(2)
                    }
                }
                else if(node.block is Sound && node.DangerZone == false){
                    SetPseudoBlocks(6)
                }
                else if(node.block is Blow && node.DangerZone == false){
                    SetPseudoBlocks(7)
                }
                node.DangerZone = true
            }
            if location.x > size.width / 1.6 && node.DangerZone{
                touchedNode.removeFromParent()
            }
        }
    }
    
    func StartPressed(){
            admin?.runBlocks(bStart)
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
                if(touchedNode is MySprite){
                    var node = touchedNode as! MySprite
                    for joint in node.MyJoints
                    {
                        self.physicsWorld.removeJoint(joint)
                        node.ParentSprite?.ChildSprite = nil
                        node.ParentSprite = nil
                    }
                }
                
                return
            }
        }
    }
}