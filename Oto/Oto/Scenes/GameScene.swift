//
//  GameScene.swift
//  Oto
//
//  Created by Enrik on 9/10/16.
//  Copyright (c) 2016 Enrik. All rights reserved.
//

import SpriteKit


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    var backgroundController: BackGroundController!
    var backGroundSpeed: CGFloat!
    
    
    var playerCarController: PlayerCarController!
    var policeCarController: PoliceCarController!
    
    
    var previousTime: CFTimeInterval = -1
    var countForE = 0
    
    var minTime: CFTimeInterval = 2
    var score = 0
    var scoreLabel: SKLabelNode!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        addBackGround()
        addScore()
        addPlayer()
        addPolice()
        addGiftPower()
        addGiftBomb()
        addGiftBullet()
        addGiftAmor()
        
        configurePhysics()
        

        //addLight()
        
    }
    
    func configurePhysics() {
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        if self.paused == true {
            let gameScene = GameScene(size: (self.view?.frame.size)!)
            
            self.view?.presentScene(gameScene, transition: SKTransition.doorsOpenHorizontalWithDuration(1))
        }
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if playerCarController.view.paused != true {
            if let touch = touches.first {
                let currentLocation = touch.locationInNode(self)
                let previousLocation = touch.previousLocationInNode(self)
                
                let dx = currentLocation.x - previousLocation.x
                playerCarController.moveByDx(dx)
                playerCarController.constraintMove(self)
                
            }
        }
    }
    
    func increasePlayerHealth(notification: NSNotification) {
        if let info = notification.userInfo as? Dictionary<String,CGFloat> {
            if let value = info["AddHealth"] {
                playerCarController.health += value
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        policeCarController.movePolice(5, speedY: 1, player: playerCarController.view, playerHealth: playerCarController.health)
        

        var enemySpeed: Double = 50
        if score < 200 {
            minTime = 3
            
        } else if score < 900 {
            minTime = 2
            enemySpeed = 100
        } else  {
            minTime = 1
            enemySpeed = 200
        }
        
        updateScore()
        
        if score < 900 {
            backGroundSpeed = CGFloat(score/30)
        } else {
            backGroundSpeed = 30
        }
        backgroundController.scrollBackGround(backGroundSpeed)
        
        if previousTime == -1 {
            previousTime = currentTime
        } else {
            let delta = currentTime - previousTime
            
            if delta > minTime {
                countForE += 1
                previousTime = currentTime
                
            }
            if countForE == 1{
                addEnemy(enemySpeed)
                countForE = 0
            }
        }
    
        
    }
    
    
    func didBeginContact(contact: SKPhysicsContact) {
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        
        let viewA = bodyA.node as! View
        let viewB = bodyB.node as! View
        
        if (bodyA.categoryBitMask | bodyB.categoryBitMask) == (PHYSICS_MASK_PLAYER_CAR | PHYSICS_MASK_POLICE_CAR) {
            if playerCarController.isShielded == false {
                gameOver()
            }
        }
        
        if let aHandleContact = viewA.handleContact {
            aHandleContact(otherView: viewB)
        }
        
        if let bHandleContact = viewB.handleContact {
            bHandleContact(otherView: viewA)
        }
        
        
    }
    
    func addGiftAmor() {
        if gameStage >= 2{
            
            let giftAmorSpawn = SKAction.runBlock {
                
                let giftAmorView = View(imageNamed: "GiftAmor")
                
                let postionX = CGFloat(arc4random_uniform(UInt32(self.frame.maxX - giftAmorView.frame.width - MARGIN_BORDER * 2))) + giftAmorView.frame.width/2 + MARGIN_BORDER
                
                giftAmorView.position = CGPoint(x: postionX, y: self.frame.height)
                
                let giftAmorController = GiftAmorController(view: giftAmorView)
                
                giftAmorController.setup(self)
                
                self.addChild(giftAmorView)
                
            }
            
            let giftAmorSpawnPeriod = SKAction.sequence([
                SKAction.waitForDuration(15),
                giftAmorSpawn
                ])
            
            self.runAction(SKAction.repeatActionForever(giftAmorSpawnPeriod))
            
            
        }
        

    }
    
    func addGiftBullet() {
        if gameStage >= 2{
            
            let giftBulletSpawn = SKAction.runBlock {
                
                let giftBulletView = View(imageNamed: "GiftBullet")
                
                let postionX = CGFloat(arc4random_uniform(UInt32(self.frame.maxX - giftBulletView.frame.width - MARGIN_BORDER * 2))) + giftBulletView.frame.width/2 + MARGIN_BORDER
                
                giftBulletView.position = CGPoint(x: postionX, y: self.frame.height)
                
                let giftBulletController = GiftBulletController(view: giftBulletView)
                
                giftBulletController.setup(self)
                
                self.addChild(giftBulletView)
                
            }
            
            let giftBulletSpawnPeriod = SKAction.sequence([
                SKAction.waitForDuration(18),
                giftBulletSpawn
                ])
            
            self.runAction(SKAction.repeatActionForever(giftBulletSpawnPeriod))
            

        }
    
    }
    
    func addGiftBomb() {
        
        let giftBombSpawn = SKAction.runBlock {
            
            let giftBombView = View(imageNamed: "Bomb")

            let postionX = CGFloat(arc4random_uniform(UInt32(self.frame.maxX - giftBombView.frame.width - MARGIN_BORDER * 2))) + giftBombView.frame.width/2 + MARGIN_BORDER
            
            giftBombView.position = CGPoint(x: postionX, y: self.frame.height)
            
            let giftBombController = GiftBombController(view: giftBombView)
            
            giftBombController.setup(self)
            
            self.addChild(giftBombView)
            
        }
        
        let giftBombSpawnPeriod = SKAction.sequence([
            SKAction.waitForDuration(15),
            giftBombSpawn
            ])
        
        self.runAction(SKAction.repeatActionForever(giftBombSpawnPeriod))
    }
    
    
    func addGiftPower() {
        
        let giftPowerSpawn = SKAction.runBlock {
            
            let giftPowerView = View(imageNamed: "health")
            
            
            let postionX = CGFloat(arc4random_uniform(UInt32(self.frame.maxX - giftPowerView.frame.width - MARGIN_BORDER * 2))) + giftPowerView.frame.width/2 + MARGIN_BORDER
            
            giftPowerView.position = CGPoint(x: postionX, y: self.frame.height)
            
            let giftPowerController = GiftPowerController(view: giftPowerView)
            
            giftPowerController.setup(self)
            
            self.addChild(giftPowerView)
            
        }
        
        let giftPowerSpawnPeriod = SKAction.sequence([
            SKAction.waitForDuration(10),
            giftPowerSpawn
            ])
        
        self.runAction(SKAction.repeatActionForever(giftPowerSpawnPeriod))
    }
    
    func addEnemy(speed: Double) {
        
        // set random image
        let randomNumber = Int(arc4random_uniform(3)) + 1
        let imageName = "EnemyCar\(randomNumber)"
        let enemyView = EnemyCarView(imageNamed: imageName)
        
        // set postion
        let positionX = CGFloat(arc4random_uniform(UInt32(self.frame.maxX - enemyView.frame.width - MARGIN_BORDER * 2))) + enemyView.frame.width/2 + MARGIN_BORDER
        
        
        enemyView.position = CGPoint(x: positionX, y: self.frame.maxY)
        
        let enemyCarController = EnemyCarController(view: enemyView)
        
        enemyCarController.setup(self)
        enemyCarController.addRunAction(speed, parent: self)
        
        enemyView.name = "enemy"
        
        self.addChild(enemyView)
        
    }
    
    
    func addPlayer() {
        let playerView = PlayerCarView(imageNamed: "Car5.png")
        playerView.position = CGPoint(x: self.frame.width/2, y: 200)
        self.playerCarController = PlayerCarController(view: playerView)
        self.playerCarController.setup(self)
        playerView.name = "player"
        addChild(playerView)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(increasePlayerHealth(_:)), name: "Increase Health", object: nil)
        
    }
    
    //    func addLight() {
    //
    //        let light = SKLightNode()
    //        light.falloff = 1
    //        light.categoryBitMask = 1
    //        light.setScale(2)
    //        light.ambientColor = UIColor.darkGrayColor()
    //
    //        backGround1.lightingBitMask = 1
    //        backGround2.lightingBitMask = 1
    //        police.shadowCastBitMask = 1
    //        police.lightingBitMask = 1
    //
    //        for enemy in enemys {
    //            enemy.shadowCastBitMask = 1
    //            enemy.lightingBitMask = 1
    //        }
    //
    //        player.addChild(light)
    //    }
    
    func addPolice() {
        let policeView = PoliceCarView(imageNamed: "PoliceCar2")
        
        policeView.position = CGPoint(x: playerCarController.view.position.x, y: playerCarController.view.position.y - playerCarController.view.frame.height/2 - policeView.frame.height/2 - playerCarController.health)
        policeCarController = PoliceCarController(view: policeView)
        policeCarController.setup(self)
        addChild(policeView)
        
        if gameStage >= 2 {
            policeCarController.updateStage(self)
        }
        
    }
    
    
    func updateScore() {
        score += 1
        scoreLabel.text = String(score)
        
        if (score > 500) && (gameStage == 1) {
            moveToStage(2)
        }
    }
    
    func addScore() {
        let scoreText = SKLabelNode(text: "Score:")
        scoreText.fontColor = UIColor.blueColor()
        scoreText.fontSize = 15
        scoreText.fontName = "Verdana-Bold"
        scoreText.position = CGPoint(x: self.frame.width - 100, y: self.frame.height - 15)
        addChild(scoreText)
        
        scoreLabel = SKLabelNode(text: String(score))
        scoreLabel.fontColor = UIColor.blueColor()
        scoreLabel.fontSize = 15
        scoreLabel.horizontalAlignmentMode = .Left
        scoreLabel.fontName = "Verdana-Bold"
        scoreLabel.position = CGPoint(x: self.frame.width - 50, y: self.frame.height - 15)
        addChild(scoreLabel)
        
    }
    
    func gameOver() {
        
        gameStage = 1
        
        let gameOverText = SKLabelNode(text: "GAME OVER")
        gameOverText.fontSize = 44
        gameOverText.fontColor = UIColor.redColor()
        
        gameOverText.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        
        addChild(gameOverText)
        
        //playerCarController.view.removeFromParent()
        
        playerCarController.view.paused = true
        
        self.paused = true
        
    }
    
    func addBackGround() {
        backgroundController = BackGroundController()
        backgroundController.setup(self)
    }
    
    func moveToStage(stage: Int) {
        
        gameStage += 1
        
        self.paused = true
        playerCarController.view.paused = true
        
        let moveStageText = SKLabelNode(text: "Move To Stage \(stage)")
        moveStageText.fontSize = 30
        moveStageText.fontName = "Tahoma"
        moveStageText.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        
        addChild(moveStageText)
    
        let tapText = SKLabelNode(text: "Tap To Start")
        tapText.fontSize = 20
        tapText.fontName = "Tahoma"
        tapText.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2 - 30)
        
        addChild(tapText)
        
        
    }
    
}












