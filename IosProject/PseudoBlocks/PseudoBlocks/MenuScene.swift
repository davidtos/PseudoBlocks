import SpriteKit

class MenuScene: SKScene,SKPhysicsContactDelegate {
    
    let background = SKSpriteNode(imageNamed: "StartScreen")
    let PlayButton = SKSpriteNode(imageNamed: "PlayButton")
    let ShareButton = SKSpriteNode(imageNamed: "ShareButton")
    let LevelsButton = SKSpriteNode(imageNamed: "LevelsButton")
    
	let reveal = SKTransition.flipHorizontalWithDuration(0.5)
	
	
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
                let gameScene = GameScene(size: self.size)
                self.view?.presentScene(gameScene, transition: reveal)
            }
            
        }
        
    }
}