//
//  BackGroundController.swift
//  Oto
//
//  Created by Enrik on 10/1/16.
//  Copyright © 2016 Enrik. All rights reserved.
//

import SpriteKit

class BackGroundController {
    
    var backGround1: SKSpriteNode!
    var backGround2: SKSpriteNode!
    var bridge1:SKSpriteNode!
    var bridge2:SKSpriteNode!
    var backgroundMusic: SKAudioNode!
    
    
    func setup(parent: SKNode) {
        
        addBackgroundMusic(parent)
        addBackGround(parent)
        addBridge()
        addTree()
    }
    
    func addBackgroundMusic(parent: SKNode) {
        parent.runAction(
            SKAction.sequence([
                SKAction.runBlock({ 
                    if let musicURL = NSBundle.mainBundle().URLForResource("backGround_Sound", withExtension: "mp3") {
                        
                        print("addBackgroundMusic")
                        
                        self.backgroundMusic = SKAudioNode(URL: musicURL)
                        
                    }
                }),
                SKAction.waitForDuration(1),
                SKAction.runBlock({ 
                     parent.addChild(self.backgroundMusic)
                    
                })
                    
                ])
        )
        
        
        
        
    }
    
    func addBackGround(parent: SKNode){
        backGround1 = SKSpriteNode(imageNamed: "backGround")
        backGround2 = SKSpriteNode(imageNamed: "backGround")
        
        backGround1.anchorPoint = CGPointZero
        backGround1.position = CGPointZero
        
        backGround2.anchorPoint = CGPointZero
        backGround2.position = CGPoint(x: backGround1.position.x, y: parent.frame.height)
        
        backGround1.size = parent.frame.size
        backGround2.size = parent.frame.size
        
        parent.addChild(backGround1)
        parent.addChild(backGround2)
    }
    
    func scrollBackGround(speed: CGFloat){
        backGround1.position = CGPoint(x: backGround1.position.x, y: backGround1.position.y - speed)
        backGround2.position = CGPoint(x: backGround2.position.x, y: backGround2.position.y - speed)
        
        if backGround1.position.y < -backGround1.frame.height  {
            backGround1.position.y = backGround2.position.y + backGround2.frame.height - 10
        }
        
        if backGround2.position.y < -backGround2.frame.height  {
            backGround2.position.y = backGround1.position.y + backGround1.frame.height
        }
        
    }
    
    func addBridge() {
        bridge2 = SKSpriteNode(imageNamed: "bridge2.png")
        bridge2.position = CGPoint(x: backGround1.position.x + backGround1.size.width/2 , y: backGround1.position.y)
        
        bridge2.zPosition = 101
        backGround2.addChild(bridge2)
    }
    
    func addTree() {
        let tree1 = SKSpriteNode(imageNamed: "tree.png")
        tree1.size = CGSize(width: 22, height: 36)
        tree1.position = CGPoint(x: backGround2.position.x + backGround2.size.width - 11 , y:backGround2.size.height)
        
        let tree2 = SKSpriteNode(imageNamed: "tree.png")
        tree2.size = CGSize(width: 22,height: 36)
        tree2.position = CGPoint(x: backGround2.position.x + backGround2.size.width - 11 , y:backGround2.size.height - 220 )
        
        let tree3 = SKSpriteNode(imageNamed: "tree.png")
        tree3.size = CGSize(width: 22,height: 36)
        tree3.position = CGPoint(x: backGround2.position.x + 11, y: backGround2.size.height - 50 )
        
        tree3.zRotation = 3.14
        
        backGround2.addChild(tree2)
        backGround2.addChild(tree1)
        backGround2.addChild(tree3)
    }
    
}
