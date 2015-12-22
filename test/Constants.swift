//
//  Constants.swift
//  RaptorRun
//
//  Created by Julian Abhari on 7/18/15.
//  Copyright (c) 2015 Julian Abhari. All rights reserved.
//

import Foundation
import UIKit

// Configurdation
let kMLGroundHeight: CGFloat = 20

// Initial Variables
let kDefaultXToMovePerSecond: CGFloat = 350

// Collision Detection
let heroCategory: UInt32 = 0x1 << 0
let wallCategory: UInt32 = 0x1 << 1

// Game Variables
let kNumberOfPointsPerLevel = 7
let kLevelGenerationTimes: [NSTimeInterval] = [1.0, 0.9, 0.8, 0.7, 0.6, 0.6, 0.6, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4,]