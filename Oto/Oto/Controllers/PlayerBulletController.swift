//
//  PlayerBulletController.swift
//  Oto
//
//  Created by Enrik on 10/2/16.
//  Copyright © 2016 Enrik. All rights reserved.
//

import SpriteKit

class PlayerBulletController: BaseController {
    
    let SPEED: Double = 60
    
    override func setup(parent: SKNode) {
        setupPhysics()
        addActionFly(parent)
        setupContact()
    }
    
    func setupContact() {
        self.view.handleContact = {
            otherView in
            if let enemyCarView = otherView as? EnemyCarView {
                
            }
            self.view.removeFromParent()
        }
    }
    
    func addActionFly(parent: SKNode) {
        let distanceToTop = Double(parent.frame.height + self.view.frame.height - self.view.position.y)
        
        let timeToReachTop = distanceToTop / SPEED
        
        self.view.runAction(
            SKAction.sequence([
                SKAction.moveToY(parent.frame.height + self.view.frame.height, duration: timeToReachTop),
                SKAction.removeFromParent()
                ])
        )
    }
    
    
    func setupPhysics() {
        self.view.physicsBody = SKPhysicsBody(rectangleOfSize: self.view.size)
        self.view.physicsBody?.categoryBitMask = PHYSICS_MASK_PLAYER_BULLET
        self.view.physicsBody?.collisionBitMask = 0
        self.view.physicsBody?.contactTestBitMask = PHYSICS_MASK_ENEMY_CAR
    }

    
}
