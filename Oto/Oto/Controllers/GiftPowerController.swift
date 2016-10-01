//
//  GiftPowerController.swift
//  Oto
//
//  Created by Enrik on 10/1/16.
//  Copyright © 2016 Enrik. All rights reserved.
//

import SpriteKit

class GiftPowerController: BaseController {
    
    let SPEED: Double = 90
        
    override func setup(parent: SKNode) {
        addRunAction(parent)
        setupPhysics()
        setupContact()
    }
    
    func setupContact() {
        self.view.handleContact = {
            otherView in
            if let playerCarView = otherView as? PlayerCarView {
                if let increaseHealth = playerCarView.increaseHealth {
                    increaseHealth()
                }
                self.view.removeFromParent()
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
        self.view.physicsBody?.categoryBitMask = PHYSICS_MASK_GIFT_POWER
        self.view.physicsBody?.collisionBitMask = 0
        self.view.physicsBody?.contactTestBitMask = PHYSICS_MASK_PLAYER_CAR
    }

}