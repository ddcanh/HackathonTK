//
//  PlayerCarController.swift
//  Oto
//
//  Created by Enrik on 10/1/16.
//  Copyright © 2016 Enrik. All rights reserved.
//

import SpriteKit

class PlayerCarController: BaseController{
    
    let MAX_HEALTH: CGFloat = 70
    
    var health: CGFloat = 50
    
    override func setup(parent: SKNode) {
       setupPhysics()
       setupRespond()
       
        
    }
    
    func setupRespond() {
        if let playerCarView = self.view as? PlayerCarView {
            playerCarView.increaseHealth = {
                
                self.health += 10
                if self.health > self.MAX_HEALTH {
                    self.health = self.MAX_HEALTH
                }
                
            }
            playerCarView.crashEnemy = {
                self.health -= 20
                
            }
            playerCarView.getHitPoliceBullet = {
                self.health -= 10
            }
        }
    }
    
    func setupPhysics() {
        self.view.physicsBody = SKPhysicsBody(rectangleOfSize: self.view.size)
        self.view.physicsBody?.categoryBitMask = PHYSICS_MASK_PLAYER_CAR
        self.view.physicsBody?.collisionBitMask = 0
        self.view.physicsBody?.contactTestBitMask = PHYSICS_MASK_ENEMY_CAR | PHYSICS_MASK_POLICE_CAR
    }
    
    func constraintMove(parent: SKNode) {
        if view.position.x < view.frame.width/2 + MARGIN_BORDER  {
            view.position.x = view.frame.width/2 + MARGIN_BORDER
        } else if view.position.x > parent.frame.width - view.frame.width/2 - MARGIN_BORDER {
            view.position.x = parent.frame.width - view.frame.width/2 - MARGIN_BORDER
        }
    }
    
    func increaseHealthForPlayer() {
        self.health += 10
    }
}
