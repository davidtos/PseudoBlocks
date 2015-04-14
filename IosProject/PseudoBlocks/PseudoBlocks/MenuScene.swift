import SpriteKit

class MenuScene: SKScene,SKPhysicsContactDelegate {
    
    let background = SKSpriteNode(imageNamed: "StartScreen")
    let PlayButton = SKSpriteNode(imageNamed: "PlayButton")
    let ShareButton = SKSpriteNode(imageNamed: "ShareButton")
    override func didMoveToView(view: SKView) {
        physicsWorld.gravity = CGVectorMake(0, 0)
        physicsWorld.contactDelegate = self
        
        background.anchorPoint = CGPointMake(0.5, 0.5)
        background.size.height = self.size.height
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        addChild(background)
        setButtons()

    }
    
    func setButtons(){
        PlayButton.position = CGPoint(x: size.width * 0.5, y: size.height * 0.44)
        ShareButton.position = CGPoint(x: (PlayButton.position.x + (ShareButton.size.width * 2)), y: size.height * 0.44)
        
        addChild(ShareButton)
        addChild(PlayButton)
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = (touch as! UITouch).locationInNode(self)
            let touchedNode = nodeAtPoint(location)
            if PlayButton == touchedNode{
                let reveal = SKTransition.flipHorizontalWithDuration(0.5)
                let gameScene = GameScene(size: self.size)
                self.view?.presentScene(gameScene, transition: reveal)
            }
            
        }
        
    }
}