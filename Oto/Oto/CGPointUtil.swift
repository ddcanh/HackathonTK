//
//  CGPointUtil.swift
//  Oto
//
//  Created by Enrik on 9/10/16.
//  Copyright © 2016 Enrik. All rights reserved.
//

import SpriteKit

extension CGPoint {
    func add(other: CGPoint) -> CGPoint {
        return CGPoint(x: self.x + other.x, y: self.y + other.y)
    }
    
    func subtract(other: CGPoint) -> CGPoint {
        return CGPoint(x: self.x - other.x, y: self.y - other.y)
    }
}
