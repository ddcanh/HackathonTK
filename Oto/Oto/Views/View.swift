//
//  View.swift
//  Oto
//
//  Created by Enrik on 10/1/16.
//  Copyright © 2016 Enrik. All rights reserved.
//

import SpriteKit


typealias HandleContactType = ((otherView: View) -> Void)

class View: SKSpriteNode {
    var handleContact : HandleContactType?
}
