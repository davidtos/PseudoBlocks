//
//  EndLevelScene.swift
//  PseudoBlocks
//
//  Created by David Vlijmincx on 08/05/15.
//  Copyright (c) 2015 FHICT. All rights reserved.
//

import SpriteKit

class EndLevelScene: SKScene,SKPhysicsContactDelegate {

    let background = SKSpriteNode(imageNamed: "EndGame")
    let BackButtonSprite = MySprite(imageNamed: "BackButton")
    
    override func didMoveToView(view: SKView) {
        physicsWorld.gravity = CGVectorMake(0, 0)
        physicsWorld.contactDelegate = self
        
        background.anchorPoint = CGPointMake(0.5, 0.5)
        background.size.height = self.size.height
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        background.zPosition = -1
        addChild(background)
        
        
        var startPointHeigt : CGFloat
        var startPointWidth : CGFloat
        
        //calculate position of the buttons
        startPointHeigt = size.height - (BackButtonSprite.size.height * 0.6)
        startPointWidth = size.width - BackButtonSprite.size.width * 2.5
        
        BackButtonSprite.position = CGPoint(x:(BackButtonSprite.size.width * 0.6) , y: startPointHeigt)
        addChild(BackButtonSprite)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = (touch as! UITouch).locationInNode(self)
            let touchedNode = nodeAtPoint(location)
            
            if(touchedNode == BackButtonSprite){
                let menuScene = MenuScene(size: self.size)
                let reveal = SKTransition.doorsCloseHorizontalWithDuration(0.5)
                self.view?.presentScene(menuScene, transition: reveal)
            }
        }
    }


}
