//
//  PlayerCarView.swift
//  Oto
//
//  Created by Enrik on 10/1/16.
//  Copyright © 2016 Enrik. All rights reserved.
//

import SpriteKit

typealias IncreaseHealth = (() -> Void)
typealias CrashEnemy = (() -> Void)
typealias CrashPolice = (() -> Void)

class PlayerCarView: View {
    var increaseHealth: IncreaseHealth?
    var crashEnemy: CrashEnemy?
    var crashPolice: CrashPolice?
}
