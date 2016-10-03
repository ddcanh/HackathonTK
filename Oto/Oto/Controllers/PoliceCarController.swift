//
//  PoliceCarController.swift
//  Oto
//
//  Created by Enrik on 10/1/16.
//  Copyright © 2016 Enrik. All rights reserved.
//

import SpriteKit

class PoliceCarController: BaseController {
    
    let SHOT_DURATION: Double = 5
    
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
    
    func addShotAction(parent: SKNode) {
        var textures : [SKTexture] = []
        for i in 1...2 {
            let imageName = "PoliceCar\(i).png"
            let texture = SKTexture(imageNamed: imageName)
            textures.append(texture)
        }
        
        let animate = SKAction.animateWithTextures(textures, timePerFrame: 0.02)
        
        self.view.runAction(
            SKAction.repeatActionForever(
                    SKAction.sequence([
                        SKAction.waitForDuration(4),
                        SKAction.repeatAction(animate, count: 50),
                        SKAction.runBlock { self.addBullet(parent) }
                    ])
            )
        )
    }
    
    func addBullet(parent: SKNode) {
        let policeBulletView = View(imageNamed: "bulletPolice.png")
        policeBulletView.position = self.view.position
        
        let policeBulletController = PoliceBulletController(view: policeBulletView)
        policeBulletController.setup(parent)
        parent.runAction(SKAction.playSoundFileNamed("PoliceBullet.wav", waitForCompletion: false))
        policeBulletView.zPosition = ZPOSITION_BULLET
        parent.addChild(policeBulletView)
    }
    
    func updateStage(parent: SKNode) {
        
        addShotAction(parent)
    }
    
}
