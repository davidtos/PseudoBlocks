import SpriteKit

class LevelSelectScene: SKScene,SKPhysicsContactDelegate {

    let background = SKSpriteNode(imageNamed: "LevelSelectBackground")
    let BackButtonSprite = MySprite(imageNamed: "BackButton")
    let reveal = SKTransition.doorsCloseHorizontalWithDuration(0.5)
    
    override func didMoveToView(view: SKView) {
        physicsWorld.gravity = CGVectorMake(0, 0)
        physicsWorld.contactDelegate = self
        
        background.anchorPoint = CGPointMake(0.5, 0.5)
        background.size.height = self.size.height
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        addChild(background)
        background.zPosition = -1
        SetButtons()
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
        
        startPointHeigt = size.height - (BackButtonSprite.size.height * 0.6)
        startPointWidth = size.width - BackButtonSprite.size.width * 2.5
        
        for i in 0...4{
            let levelButtonSprite = MySprite(imageNamed: "BackButton" + String(i))
            
            
            addChild(levelButtonSprite)
        }

        
    }
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = (touch as! UITouch).locationInNode(self)
            let touchedNode = nodeAtPoint(location)
            
            if BackButtonSprite == touchedNode{
                let menuScene = MenuScene(size: self.size)
                self.view?.presentScene(menuScene, transition: reveal)
            }
//            else if LevelsButton == touchedNode {
//                let levelSelectScene = LevelSelectScene(size: self.size)
//                self.view?.presentScene(levelSelectScene, transition: reveal)
//          }
        }
    }
}