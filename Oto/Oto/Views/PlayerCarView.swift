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
typealias GetHitPoliceBullet = (() -> Void)
typealias EatGiftBullet = (() -> Void)
typealias EatGiftAmor = (() -> Void)

class PlayerCarView: View {
    var increaseHealth: IncreaseHealth?
    var crashEnemy: CrashEnemy?
    var crashPolice: CrashPolice?
    var getHitPoliceBullet: GetHitPoliceBullet?
    var eatGiftBullet: EatGiftBullet?
    var eatGiftAmor: EatGiftAmor?
}
