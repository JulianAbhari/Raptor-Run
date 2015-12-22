//
//  GameScene.swift
//  test
//
//  Created by Julian Abhari on 6/27/15.
//  Copyright (c) 2015 Julian Abhari. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var hero: MLHero!
    var movingGround: MLMovingGround!
    var raptor: MLRaptor!
    var wallGenerator: MLWallGenerator!
    var GameViewController: UIViewController!
    
    var isStarted = false
    var isGameOver = false
    
    var currentLevel = 0
    
    override func didMoveToView(view: SKView) {
       //add moving background
        
        backgroundColor = UIColor(red: 180.0/255, green: 180.0/255, blue: 180.0/255, alpha: 1.0)
        
        var bgTexture = SKTexture(imageNamed: "Backgroundimage")
        var movebg = SKAction.moveByX(-bgTexture.size().width, y: 0, duration: 9)
        var replacebg = SKAction.moveByX(bgTexture.size().width, y: 0, duration: 0)
        var moveForever = SKAction.repeatActionForever(SKAction.sequence([movebg, replacebg]))
        
        for var i:CGFloat=0; i<3; i++ {
            
            var scrollbg = SKSpriteNode(texture: bgTexture)
            scrollbg.position = CGPoint(x: bgTexture.size().width/2 + bgTexture.size().width * i, y: CGRectGetMidY(self.frame))
            scrollbg.size.height = self.frame.height
            
            scrollbg.runAction(moveForever)
            
            self.addChild(scrollbg)
            
        }

        //add ground
        movingGround = MLMovingGround(size: CGSizeMake(view.frame.width, 27))
        movingGround.position = CGPointMake(0, 10)
        addChild(movingGround)
       
        //add hero
        hero = MLHero()
        hero.position = CGPointMake(310, movingGround.position.y + movingGround.frame.size.height/2 + hero.frame.size.height/2)
        addChild(hero)
        
        //add raptor
        raptor = MLRaptor()
        raptor.position = CGPointMake(100, movingGround.position.y + movingGround.frame.size.height/2 + raptor.frame.size.height/2)
        addChild(raptor)
        
        //add walls
        wallGenerator = MLWallGenerator(color: UIColor.clearColor(), size: view.frame.size)
        addChild(wallGenerator)
        
        //add start label
        let tapToStartLable = SKLabelNode(text: "Tap to Start!")
        tapToStartLable.name = "tapToStartLabel"
        tapToStartLable.position = view.center
        tapToStartLable.fontColor = UIColor.blackColor()
        addChild(tapToStartLable)
        
        //add pointsLabel
            let pointsLabel = MLPointsLabel(num: 0)
            pointsLabel.position = CGPointMake(38.0, view.frame.size.height - 78.0)
            pointsLabel.name = "pointsLabel"
            addChild(pointsLabel)
        
            let highscoreLabel = MLPointsLabel(num: 0)
            highscoreLabel.name = "highscoreLabel"
            highscoreLabel.position = CGPointMake(view.frame.size.width - 35.0, view.frame.size.height - 78 )
            addChild(highscoreLabel)
        
            let highscoreTextLabel = SKLabelNode(text: "Highscore:")
            highscoreTextLabel.fontColor = UIColor.blackColor()
            highscoreTextLabel.fontSize = 30.0
            highscoreTextLabel.position = CGPointMake(-105, 2)
            highscoreLabel.addChild(highscoreTextLabel)
        
        
        
        func loadHighscore() {
            let defaults = NSUserDefaults.standardUserDefaults()
            
            let highscoreLabel = childNodeWithName("highscoreLabel") as! MLPointsLabel
            highscoreLabel.setTo(defaults.integerForKey("highscore"))
        }
        
        loadHighscore()
        
        //add physics world
        physicsWorld.contactDelegate = self
        
        //add swipe gestures
        let swipeUp:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedUp:"))
        swipeUp.direction = .Up
        view.addGestureRecognizer(swipeUp)
        
        
        let swipeDown:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action:
            Selector("swipedDown:"))
        swipeDown.direction = .Down
        view.addGestureRecognizer(swipeDown)

    }
    
    func start() {
        
        isStarted = true
        
        let tapToStartLabel = childNodeWithName("tapToStartLabel")
        tapToStartLabel?.removeFromParent()
        
        hero.start()
        hero.stopduck()
        raptor.start()
        movingGround.start()
        wallGenerator.startGeneratingWallsEvery(1)
    }
    
    func gameOver() {
        isGameOver = true
        
        // stop everything
        wallGenerator.stopWalls()
        hero.stop()
        hero.stopduck()
        raptor.stop()
        movingGround.stop()
        
        hero.physicsBody = nil
        
        // create game over label
        let gameOverLabel = SKLabelNode(text: "Game Over!")
        gameOverLabel.fontColor = UIColor.blackColor()
        gameOverLabel.position = view!.center
        addChild(gameOverLabel)
        
        // save current points label value
        let pointsLabel = childNodeWithName("pointsLabel") as! MLPointsLabel
        let highscoreLabel = childNodeWithName("highscoreLabel") as! MLPointsLabel
        
        if highscoreLabel.number < pointsLabel.number {
            highscoreLabel.setTo(pointsLabel.number)
            
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setInteger(highscoreLabel.number, forKey: "highscore")
        }
    }
    
    func restart() {
        let newScene = GameScene(size: view!.bounds.size)
        newScene.scaleMode = .AspectFill
        
        view!.presentScene(newScene)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if isGameOver {
            restart()
        }
        
        if !isStarted {
            start()
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        hero.stopduck()
        hero.start()
        hero.position = CGPointMake(310, movingGround.position.y + movingGround.frame.size.height/2 + hero.frame.size.height/2)
    }
    
    func swipedDown(sender:UISwipeGestureRecognizer){
        if (sender.direction == .Down) {
            
            hero.duck()
            hero.stop()
            hero.position = CGPointMake(310, movingGround.position.y + movingGround.frame.size.height/2 + hero.frame.size.height/50)
            
       }
    }

    func swipedUp(sender:UISwipeGestureRecognizer){
        if (sender.direction == .Up) {
            
             hero.start()
             hero.stopduck()
             hero.position = CGPointMake(310, movingGround.position.y + movingGround.frame.size.height/2 + hero.frame.size.height/0.9)
            let delay = 0.32 * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue()) {
            self.hero.position = CGPointMake(310, self.movingGround.position.y + self.movingGround.frame.size.height/2 + self.hero.frame.size.height/2)
                
            }
            
        }
    }
    
    
    func accelaritionOfWall() ->Int
    {
        
        if currentLevel < 7
        {   return currentLevel
        }else
        {return 7}
    }
    
    override func update(currentTime: CFTimeInterval) {
        if wallGenerator.wallTrackers.count > 0 {
         
            let wall = wallGenerator.wallTrackers[0] as MLWall
            
            let wallLocation = wallGenerator.convertPoint(wall.position, toNode: self)
            if wallLocation.x <= hero.position.x {
                wallGenerator.wallTrackers.removeAtIndex(0)
                
                let pointsLabel = childNodeWithName("pointsLabel") as! MLPointsLabel
                pointsLabel.increment()
                
                if pointsLabel.number % kNumberOfPointsPerLevel == 0{
                    
                    wallGenerator.stopGenerating()
                    
                    currentLevel++
                    wallGenerator.startGeneratingWallsEvery(kLevelGenerationTimes[accelaritionOfWall()])
                }
                
            }
            
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        gameOver()
    }
    
}