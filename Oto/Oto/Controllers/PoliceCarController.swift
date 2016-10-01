//
//  PoliceCarController.swift
//  Oto
//
//  Created by Enrik on 10/1/16.
//  Copyright © 2016 Enrik. All rights reserved.
//

import SpriteKit

class PoliceCarController: BaseController {
    
    override func setup(parent: SKNode) {
        setupPhysics()
        
    }
    

    
    func setupPhysics() {
        self.view.physicsBody = SKPhysicsBody(rectangleOfSize: self.view.size)
        self.view.physicsBody?.categoryBitMask = PHYSICS_MASK_POLICE_CAR
        self.view.physicsBody?.collisionBitMask = 0
        self.view.physicsBody?.contactTestBitMask = PHYSICS_MASK_PLAYER_CAR | PHYSICS_MASK_ENEMY_CAR
    }
    
    func movePolice(speedX: CGFloat, speedY: CGFloat, player: SKSpriteNode, playerHealth: CGFloat) {
        if view.position.x < player.position.x - speedX {
            view.position.x += speedX
            view.zRotation = -0.1
        } else if view.position.x > player.position.x + speedX {
            view.position.x -= speedX
            view.zRotation = 0.1
        } else {
            view.zRotation = 0
        }
        
        let positionY = player.position.y - player.frame.height/2 - view.frame.height/2 - playerHealth
        
        if view.position.y < positionY - 1 {
            view.position.y += speedY
        } else if view.position.y > positionY + 1 {
            view.position.y -= speedY
        }
    }
    
}
