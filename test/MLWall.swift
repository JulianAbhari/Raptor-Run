//
//  MLWall.swift
//  RaptorRun
//
//  Created by Julian Abhari on 7/21/15.
//  Copyright (c) 2015 Julian Abhari. All rights reserved.
//

import Foundation
import SpriteKit

class MLWall: SKSpriteNode {
    
    let WALL_WIDTH: CGFloat = 26.0
    let WALL_HEIGHT: CGFloat = 50.0
    let WALL_COLOR = UIColor.blackColor()
    
    init() {
        let size = CGSizeMake(WALL_WIDTH, WALL_HEIGHT)
        super.init(texture: nil, color: WALL_COLOR, size: size)
        loadPhysicsBodyWithSize(size)
        startMoving()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startMoving() {
        let moveLeft = SKAction.moveByX(-kDefaultXToMovePerSecond, y: 0, duration: 1)
        runAction(SKAction.repeatActionForever(moveLeft))
    }
    
    func loadPhysicsBodyWithSize(size: CGSize) {
        physicsBody = SKPhysicsBody(rectangleOfSize: size)
        physicsBody?.categoryBitMask = wallCategory
        physicsBody?.contactTestBitMask = heroCategory
        physicsBody?.affectedByGravity = false
        physicsBody?.dynamic = false
        
    }
    
    func stopMoving() {
        removeAllActions()
    }
}