//
//  EnemyCarView.swift
//  Oto
//
//  Created by Enrik on 10/1/16.
//  Copyright © 2016 Enrik. All rights reserved.
//

import SpriteKit

typealias GetHitPlayerBullet = (() -> Void)

class EnemyCarView: View {
    
    var getHitPlayerBullet: GetHitPlayerBullet?
}
