//
//  MLWallGenerator.swift
//  RaptorRun
//
//  Created by Julian Abhari on 7/21/15.
//  Copyright (c) 2015 Julian Abhari. All rights reserved.
//

import Foundation
import SpriteKit

class MLWallGenerator: SKSpriteNode {
    
    var generationTimer: NSTimer?
    var walls = [MLWall]()
    var wallTrackers = [MLWall]()
    
    func startGeneratingWallsEvery(seconds: NSTimeInterval) {
        generationTimer = NSTimer.scheduledTimerWithTimeInterval(seconds, target: self, selector: "generateWall", userInfo: nil, repeats: true)
        
    }
    
    func stopGenerating() {
        generationTimer?.invalidate()
    }
    
    func generateWall() {
        var scale: CGFloat = 1
        let rand = arc4random_uniform(2)
        
        if rand == 0 {
            scale = 2.2
        
        } else if rand == 1 {
            scale = 1.1
        
        }
        
        let wall = MLWall()
        wall.position.x = size.width/0.5 + wall.size.width/2
        wall.position.y = scale * (kMLGroundHeight/1 + wall.size.height/2)
        walls.append(wall)
        wallTrackers.append(wall)
        addChild(wall)
    }
    
    func stopWalls(){
        stopGenerating()
        for wall in walls {
        wall.stopMoving()
            
        }
        
    }
}