//
//  FireController.swift
//  Oto
//
//  Created by Enrik on 10/1/16.
//  Copyright © 2016 Enrik. All rights reserved.
//

import SpriteKit

class FireController {
    
    var view: SKEmitterNode!
    let SPEED: Double = 200
    
    init(parent: SKNode, position: CGPoint){
        if let explosionPath = NSBundle.mainBundle().pathForResource("Explosion", ofType: "sks") {
            view = NSKeyedUnarchiver.unarchiveObjectWithFile(explosionPath) as? SKEmitterNode
            
            view.position = position
            parent.addChild(view)
        }
    }
    
    func setup() {
        let distanceToBottom = Double(self.view.position.y + self.view.frame.height )
        let timeToBottom = distanceToBottom / SPEED
        self.view.runAction(
            SKAction.sequence([
                SKAction.moveToY(-self.view.frame.height, duration: timeToBottom),
                SKAction.removeFromParent()
            ])
        )
    }
}
