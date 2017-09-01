//
//  ShapeType.swift.swift
//  GeometryFighter
//
//  Created by Александр Менщиков on 31.08.17.
//  Copyright © 2017 Александр Менщиков. All rights reserved.
//

import Foundation
import SceneKit

enum ShapeType:Int {
    
    case box = 0
    case sphere = 1
    case pyramid = 2
    case torus = 3
    case capsule = 4
    case cylinder = 5
    case cone = 6
    case tube = 7
    
    // 2
    static func random() -> ShapeType {
        let maxValue = tube.rawValue
        let rand = arc4random_uniform(UInt32(maxValue+1))
        return ShapeType(rawValue: Int(rand))!
    }
    
    static func randomFloat(_ min:Float, _ max:Float) -> Float {
        return min + (max-min) * Float(arc4random()) / Float(UINT32_MAX)
    }
    
    static func randomPosition() -> SCNVector3 {
        return SCNVector3(x: randomFloat(-2, 2), y: randomFloat(-2, 2), z: randomFloat(-2, 2))
    }
}


