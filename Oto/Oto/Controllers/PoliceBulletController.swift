//
//  PoliceBulletController.swift
//  Oto
//
//  Created by Enrik on 10/2/16.
//  Copyright © 2016 Enrik. All rights reserved.
//

import SpriteKit

class PoliceBulletController: BaseController {
    
    let SPEED: Double = 40
    
    override func setup(parent: SKNode) {
        setupPhysics()
        addActionFly(parent)
        setupContact()
    }
    
    func setupContact() {
        self.view.handleContact = {
            otherView in
            if let playerCarView = otherView as? PlayerCarView {
                if let getHitPoliceBullet = playerCarView.getHitPoliceBullet {
                    getHitPoliceBullet()
                }
            }
            self.view.removeFromParent()
        }
    }
    
    func addActionFly(parent: SKNode) {
        let distanceToTop = Double(parent.frame.height - self.view.position.y)
        
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
        self.view.physicsBody?.categoryBitMask = PHYSICS_MASK_POLICE_BULLET
        self.view.physicsBody?.collisionBitMask = 0
        self.view.physicsBody?.contactTestBitMask = PHYSICS_MASK_PLAYER_CAR
    }
}
