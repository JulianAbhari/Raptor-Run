//
//  MLHero.swift
//  test
//
//  Created by Julian Abhari on 6/29/15.
//  Copyright (c) 2015 Julian Abhari. All rights reserved.
//

import Foundation
import SpriteKit

class MLHero: SKSpriteNode {
    
    let textureAtlas = SKTextureAtlas(named: "Images.atlas")
    var spriteArray = Array<SKTexture>()
    var spriteduckArray = Array<SKTexture>()
    
    var hero: SKSpriteNode!
    var herojump: SKSpriteNode!
    var heroduck: SKSpriteNode!
    
    init() {
        super.init(texture: nil, color: UIColor.clearColor(), size: CGSizeMake(32, 88))
    
        loadAppearance()
        loadPhysicsBodyWithSize(size)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    func loadAppearance() {
        
        spriteArray.append(textureAtlas.textureNamed("Hero1"))
        spriteArray.append(textureAtlas.textureNamed("Hero2"))
        
        hero = SKSpriteNode(texture: spriteArray[0])
        hero.setScale(1.0)
        hero.position = CGPoint(x: 5, y: 0)
        addChild(hero)
        
        CGSizeMake(88, 32)
        
        spriteduckArray.append(textureAtlas.textureNamed("Heroduck1"))
        
        
        heroduck = SKSpriteNode(texture: spriteduckArray[0])
        heroduck.setScale(0.0)
        heroduck.position = CGPoint(x: 5, y: -28)
        addChild(heroduck)
    }
    
    func loadPhysicsBodyWithSize(size: CGSize) {
        physicsBody = SKPhysicsBody(rectangleOfSize: size)
        physicsBody?.categoryBitMask = heroCategory
        physicsBody?.contactTestBitMask = wallCategory
        physicsBody?.affectedByGravity = false
    }
    
    func start() {
       
        hero.size = CGSizeMake(32, 88)
        hero.hidden = false
        let animateAction = SKAction.animateWithTextures(self.spriteArray, timePerFrame: 0.20)
        let moveAction = SKAction.moveBy(CGVector(dx: 0, dy: 0), duration: 0.0)
        let group = SKAction.group([animateAction,moveAction]),
        repeatAction = SKAction.repeatActionForever(group)
        self.hero.runAction(repeatAction)
    }
    
    func stop() {
        hero.hidden = true
        hero.removeAllActions()
    }
    
    func duck() {
        hero.size = CGSizeMake(88, 32)
        heroduck.position = CGPoint(x: 5, y: 15)
        heroduck.hidden = false
        heroduck.setScale(1.0)
        let animateAction = SKAction.animateWithTextures(self.spriteduckArray, timePerFrame: 0.20)
        let moveAction = SKAction.moveBy(CGVector(dx: 0, dy: 0), duration: 0.0)
        let group = SKAction.group([animateAction,moveAction]),
        repeatAction = SKAction.repeatActionForever(group)
        self.heroduck.runAction(repeatAction)
    }
    
    func stopduck() {
        heroduck.hidden = true
        heroduck.removeAllActions()
        
    }
    
}