import SpriteKit

class LevelSelectScene: SKScene,SKPhysicsContactDelegate {

    let background = SKSpriteNode(imageNamed: "LevelSelectBackground")
    let BackButtonSprite = MySprite(imageNamed: "BackButton")
    let reveal = SKTransition.doorsCloseHorizontalWithDuration(0.5)
    
    var levels :[[[Int]]]!
    
    override func didMoveToView(view: SKView) {
        physicsWorld.gravity = CGVectorMake(0, 0)
        physicsWorld.contactDelegate = self
        
        background.anchorPoint = CGPointMake(0.5, 0.5)
        background.size.height = self.size.height
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        addChild(background)
        background.zPosition = -1
        GenerateMaps()
        SetButtons()
        setLevels()
    }
    
    func SetButtons(){
        var startPointHeigt : CGFloat
        var startPointWidth : CGFloat
        
        startPointHeigt = size.height - (BackButtonSprite.size.height * 0.6)
        startPointWidth = size.width - BackButtonSprite.size.width * 2.5
        
        BackButtonSprite.position = CGPoint(x:(BackButtonSprite.size.width * 0.6) , y: startPointHeigt)
        addChild(BackButtonSprite)
    }
    
    func setLevels(){
        var startPointHeigt : CGFloat
        var startPointWidth : CGFloat
        var tempPoint : CGFloat
        
        startPointHeigt = size.height - (BackButtonSprite.size.height * 0.6)
        startPointWidth = size.width - BackButtonSprite.size.width * 2.5
        
        for i in 1...4{
            let levelButtonSprite = LevelSprite(imageNamed: "Level" + String(i))
            startPointWidth = (BackButtonSprite.size.width * 0.7)
            tempPoint = (BackButtonSprite.size.width * 1.3)  * CGFloat(i - 1)
            startPointWidth = BackButtonSprite.size.width  + tempPoint
            levelButtonSprite.position = CGPoint(x:startPointWidth , y: startPointHeigt - BackButtonSprite.size.width * 1.3)
            
            
            /*
            var tempLevel = Level(map:[[2,0,2,2,2,2],
                [2,0,2,2,2,2],
                [2,5,2,2,2,2],
                [2,1,4,4,0,2],
                [2,2,2,2,3,2],
                [2,2,2,2,0,2]],nummer:i)*/
            
            var CurLvl = levels[i-1]
            var tempLevel = Level(map:CurLvl,nummer:i)
            
            levelButtonSprite.level = tempLevel
            
            addChild(levelButtonSprite)
        }

        
    }
    
    // 0 = grass
    // 1 = spawn
    // 2 = wall
    // 3 = water
    // 4 = dust
    // 5 = animal
    func GenerateMaps(){
        let lvl1 = [[2,2,2,2,2,2],
                    [2,1,2,2,2,2],
                    [2,0,2,2,2,2],
                    [2,0,0,0,0,2],
                    [2,2,2,2,0,2],
                    [2,2,2,2,2,2]]
        
        let lvl2 = [[2,2,2,2,2,2],
                    [2,2,2,2,1,2],
                    [2,2,2,2,0,2],
                    [2,0,5,0,0,2],
                    [2,0,2,2,2,2],
                    [2,2,2,2,2,2]]
        
        let lvl3 = [[2,2,2,2,2,2],
                    [2,0,0,5,0,2],
                    [2,4,2,2,0,2],
                    [2,0,2,5,0,2],
                    [2,1,2,0,2,2],
                    [2,2,2,2,2,2]]
        
        let lvl4 = [[2,2,2,2,2,2],
                    [2,1,2,2,2,2],
                    [2,5,0,4,2,2],
                    [2,0,2,0,2,2],
                    [2,4,0,5,0,2],
                    [2,2,2,2,2,2]]
        
        levels = [lvl1,lvl2,lvl3,lvl4]
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = (touch as! UITouch).locationInNode(self)
            let touchedNode = nodeAtPoint(location)
            
            if BackButtonSprite == touchedNode{
                let menuScene = MenuScene(size: self.size)
                self.view?.presentScene(menuScene, transition: reveal)
            }
            else if touchedNode is LevelSprite  {
                var node = touchedNode as! LevelSprite
                
                let gameScene = GameScene(size: self.size,level: node.level!)
                self.view?.presentScene(gameScene, transition: reveal)
          }
        }
    }
}