//
//  MLPointsLabel.swift
//  RaptorRun
//
//  Created by Julian Abhari on 7/28/15.
//  Copyright (c) 2015 Julian Abhari. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import AVFoundation

class MLPointsLabel: SKLabelNode {
    
    var number = 0
    
    init(num: Int) {
        super.init()
        fontColor = UIColor.blackColor()
        fontSize = 30.0
        
        number = num
        text = "\(num)"
    
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func increment() {
        number++
        text = "\(number)"
        
    }
    
    func setTo(num: Int) {
        self.number = num
        text = "\(self.number)"
    }

}