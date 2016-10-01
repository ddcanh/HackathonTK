//
//  BombController.swift
//  Oto
//
//  Created by Enrik on 10/2/16.
//  Copyright © 2016 Enrik. All rights reserved.
//


import SpriteKit

class GiftBombController: BaseController {
    
    let SPEED: Double = 130
    
    override func setup(parent: SKNode) {
        addRunAction(parent)
        setupPhysics()
        setupContact(parent)
    }
    
    func setupContact(parent: SKNode) {
        self.view.handleContact = {
            otherView in
            if let playerCarView = otherView as? PlayerCarView {
                
                parent.runAction(SKAction.playSoundFileNamed("Explosion2.wav", waitForCompletion: false))
                self.view.removeFromParent()
                let dic: NSDictionary = ["parent": parent]
                NSNotificationCenter.defaultCenter().postNotificationName("Eat Bomb", object: nil, userInfo: dic as [NSObject : AnyObject])
            }
        }
    }
    
    func addRunAction(parent: SKNode) {
        
        let distanceToBottom = Double(self.view.position.y + self.view.frame.height)
        
        let timeToBottom = distanceToBottom / SPEED
        
        self.view.runAction(
            SKAction.sequence(
                [
                    SKAction.moveToY(-self.view.frame.height, duration: timeToBottom),
                    SKAction.removeFromParent()
                ]
            )
            
        )
        
    }
    
    func setupPhysics() {
        self.view.physicsBody = SKPhysicsBody(rectangleOfSize: self.view.size)
        self.view.physicsBody?.categoryBitMask = PHYSICS_MASK_GIFT_BOMB
        self.view.physicsBody?.collisionBitMask = 0
        self.view.physicsBody?.contactTestBitMask = PHYSICS_MASK_PLAYER_CAR
    }
    
}
