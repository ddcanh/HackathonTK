//
//  GameOverScene.swift
//  Oto
//
//  Created by Enrik on 10/2/16.
//  Copyright © 2016 Enrik. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {
    
    var score: Int!
    
    override func didMoveToView(view: SKView) {
        
        addLabel()
    }
    
    func addLabel() {
        let labelGameOver = SKLabelNode(text: "Game Over")
        labelGameOver.fontName = "Tahoma"
        labelGameOver.fontSize = 40
        labelGameOver.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        addChild(labelGameOver)
        
        let labelTap = SKLabelNode(text: "Tap To Replay")
        labelTap.fontName = "Tahoma"
        labelTap.fontSize = 20
        labelTap.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2 - 80)
        addChild(labelTap)
        
        let labelScoreText = SKLabelNode(text: "Score: ")
        labelScoreText.fontName = "Tahoma"
        labelScoreText.fontSize = 15
        labelScoreText.position = CGPoint(x: self.frame.width / 2 - 20, y: self.frame.height / 2 + 80)
        addChild(labelScoreText)
        
        let labelScore = SKLabelNode()
        labelScore.text = String(self.score)
        labelScore.fontName = "Tahoma"
        labelScore.fontSize = 15
        labelScore.position = CGPoint(x: self.frame.width / 2 + 20, y: self.frame.height / 2 + 80)
        addChild(labelScore)
 
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let gameScene = GameScene(size: self.view!.frame.size)
        
        self.view?.presentScene(gameScene, transition: SKTransition.doorsOpenHorizontalWithDuration(1))
    }
}
