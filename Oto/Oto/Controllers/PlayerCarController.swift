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
    var isShielded: Bool = false
    
    override func setup(parent: SKNode) {
       setupPhysics()
       setupRespond(parent)
       
        
    }
    
    func setupRespond(parent: SKNode) {
        if let playerCarView = self.view as? PlayerCarView {
            playerCarView.increaseHealth = {
                
                self.health += 10
                if self.health > self.MAX_HEALTH {
                    self.health = self.MAX_HEALTH
                }
                
            }
            playerCarView.crashEnemy = {
                if self.isShielded == false {
                    if self.health > 0 {
                        self.health -= 20
                    }
                }
                
            }
            playerCarView.getHitPoliceBullet = {
                if self.isShielded == false {
                    if self.health > 0{
                         self.health -= 10
                    }
                }
            }
            playerCarView.eatGiftBullet = {
                self.addShotAction(parent)
            }
            playerCarView.eatGiftAmor = {
                self.takeShield()
                
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
    
    
    func addShotAction(parent: SKNode) {
        self.view.runAction(
            SKAction.repeatAction(
                SKAction.sequence([
                SKAction.runBlock { self.addBullet(parent) },
                SKAction.waitForDuration(1)
                ])
            ,count: 5)
        )
        
    }

    func addBullet(parent: SKNode) {
        let playerBulletView = View(imageNamed: "playerBullet.png")
        playerBulletView.position = self.view.position
        
        let playerBulletController = PlayerBulletController(view: playerBulletView)
        playerBulletController.setup(parent)
        parent.runAction(SKAction.playSoundFileNamed("PlayerBullet.wav", waitForCompletion: false))
        
        parent.addChild(playerBulletView)
    }
    
    
    func takeShield() {
        var textures : [SKTexture] = []
        for i in 1...5 {
            let imageName = "Car\(i).png"
            let texture = SKTexture(imageNamed: imageName)
            textures.append(texture)
        }
        
        let animate = SKAction.animateWithTextures(textures, timePerFrame: 0.02)
        
        self.view.runAction(
            SKAction.sequence([
                SKAction.runBlock({ 
                    self.isShielded = true
                    self.view.runAction(SKAction.repeatAction(animate, count: 50))
                }),
                SKAction.waitForDuration(5),
                SKAction.runBlock({ 
                    self.isShielded = false
                })
            ])
        )
    }

}












