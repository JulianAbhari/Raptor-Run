//
//  MLMovingGround.swift
//  test
//
//  Created by Julian Abhari on 6/28/15.
//  Copyright (c) 2015 Julian Abhari. All rights reserved.
//

import Foundation
import SpriteKit

class MLMovingGround: SKSpriteNode {
    
    let NUMBER_OF_SEGMENTS = 20
    let COLOR_ONE = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1.0)
    let COLOR_TWO = UIColor(red: 140/255, green: 140/255, blue: 140/255, alpha: 1.0)
    
    init(size: CGSize) {
        super.init(texture: nil, color: UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1.0), size: CGSizeMake(size.width*2, size.height))
        anchorPoint = CGPointMake(0, 0.5)
        
        for var i = 0; i < NUMBER_OF_SEGMENTS; i++ {
            var segmentColor: UIColor!
            
            if i % 2 == 0 {
                segmentColor = COLOR_ONE
            
            } else {
                
                segmentColor = COLOR_TWO
            }
            
            let segment = SKSpriteNode(color: segmentColor, size: CGSizeMake(self.size.width / CGFloat(NUMBER_OF_SEGMENTS), self.size.height))
            segment.anchorPoint = CGPointMake(0.0, 0.5)
            segment.position = CGPointMake(CGFloat(i)*segment.size.width, 0)
            addChild(segment)
            
        }
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func start() {
        let adjustedDuration = NSTimeInterval(frame.size.width / kDefaultXToMovePerSecond)
        
        
        let moveLeft = SKAction.moveByX(-frame.size.width/2, y: 0, duration: adjustedDuration/2)
        let resetPosition = SKAction.moveToX(0, duration: 0)
        let moveSequence = SKAction.sequence([moveLeft, resetPosition])
        
        runAction(SKAction.repeatActionForever(moveSequence))
        
        
        
    }
    
    func stop() {
        removeAllActions()
    }
}
