//
//  EnemyCarController.swift
//  Oto
//
//  Created by Enrik on 10/1/16.
//  Copyright © 2016 Enrik. All rights reserved.
//

import SpriteKit

class EnemyCarController: BaseController {
    
    override func setup(parent: SKNode) {
        setupPhysics()
        setupContact(parent)
    }
    func setupContact(parent: SKNode) {
        self.view.handleContact = {
            otherView in
            if let playerCarView = otherView as? PlayerCarView {
                if let crashEnemy = playerCarView.crashEnemy {
                    crashEnemy()
                }
            } else if let policeCarView = otherView as? PoliceCarView {
            
               let dic: NSDictionary = ["AddHealth":10]
               NSNotificationCenter.defaultCenter().postNotificationName("Increase Health", object: nil, userInfo: dic as [NSObject : AnyObject])
                
            }
            parent.runAction(SKAction.playSoundFileNamed("CrashCar.mp3", waitForCompletion: false))
            self.addExplosionEffect(parent, postion: self.view.position)
            self.view.removeFromParent()
        }
    }
    
    func addExplosionEffect(parent: SKNode, postion: CGPoint) {
        let explosion = FireController(parent: parent, position: self.view.position)
        explosion.setup()
    }
    
    
    func setupPhysics() {
        self.view.physicsBody = SKPhysicsBody(rectangleOfSize: self.view.size)
        self.view.physicsBody?.categoryBitMask = PHYSICS_MASK_ENEMY_CAR
        self.view.physicsBody?.collisionBitMask = PHYSICS_MASK_ENEMY_CAR
        self.view.physicsBody?.contactTestBitMask = PHYSICS_MASK_PLAYER_CAR | PHYSICS_MASK_POLICE_CAR
    }
    
    func addRunAction(speed: Double, parent: SKNode) {
        let distanceToBottom = Double(self.view.position.y + self.view.frame.height)
        
        let timeToReachBottom = distanceToBottom / speed
        
        self.view.runAction(
            SKAction.sequence(
                [
                    SKAction.moveToY(-self.view.frame.height, duration: timeToReachBottom),
                    SKAction.removeFromParent()
                ]
            )
        )
        
    }
}
