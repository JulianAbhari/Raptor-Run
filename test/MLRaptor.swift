//
//  MLSpider.swift
//  test
//
//  Created by Julian Abhari on 7/2/15.
//  Copyright (c) 2015 Julian Abhari. All rights reserved.
//

import Foundation
import SpriteKit

class MLRaptor: SKSpriteNode {
    let textureAtlas = SKTextureAtlas(named: "Images.atlas")
    var spriteArray = Array<SKTexture>()
    
    var raptor: SKSpriteNode!
    
    init() {
        super.init(texture: nil, color: UIColor.clearColor(), size: CGSizeMake(110, 77))
        
        spriteArray.append(textureAtlas.textureNamed("Raptor1"))
        spriteArray.append(textureAtlas.textureNamed("Raptor2"))
        
        raptor = SKSpriteNode(texture: spriteArray[0])
        raptor.setScale(1.0)
        raptor.position = CGPoint(x: 11, y: 0)
        raptor.zPosition = 1
        addChild(raptor)
    
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func start() {
        
        let animateAction = SKAction.animateWithTextures(self.spriteArray, timePerFrame: 0.15)
        let moveAction = SKAction.moveBy(CGVector(dx: 0, dy: 0), duration: 0.0)
        let group = SKAction.group([animateAction,moveAction]),
        repeatAction = SKAction.repeatActionForever(group)
        self.raptor.runAction(repeatAction)
        
    }
    
    func stop() {
        raptor.removeAllActions()
        raptor.hidden = true
    }
    
}
