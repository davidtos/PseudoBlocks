//
//  Swim.swift
//  PseudoBlocks
//
//  Created by fhict on 13/04/15.
//  Copyright (c) 2015 FHICT. All rights reserved.
//

import Foundation
import CoreMotion

class Swim: Block {
    
    var motionManager = CMMotionManager()
    
    var curMaxAccelX: Double = 0.0
    var curMaxAccelY: Double = 0.0
    var curMaxAccelZ: Double = 0.0
    
    
    func start() {
        // set motion maneger propperty
        motionManager.accelerometerUpdateInterval = 0.2
        
        ResetMaxAccel()
        
        //start receiving data
        motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue(),
            withHandler: { (accelerometerData: CMAccelerometerData!, error: NSError!) -> Void
                in
                self.outputAccelerationData(accelerometerData.acceleration)
                if (error != nil){
                    println("\(error)")
                }
            })
        
    }
    
    func stop()
    {
        ResetMaxAccel()
        motionManager.stopAccelerometerUpdates()
    }
    
    func ResetMaxAccel()
    {
         curMaxAccelX = 0
         curMaxAccelY = 0
         curMaxAccelZ = 0
    }
    
    func outputAccelerationData(acceleration: CMAcceleration){
        // set x acceration
        if fabs(acceleration.x) > fabs(curMaxAccelX){
            curMaxAccelX = acceleration.x
        }
        
        // set y acceration
        if fabs(acceleration.y) > fabs(curMaxAccelY){
            curMaxAccelY = acceleration.y
        }
        
        // set x acceration
        if fabs(acceleration.z) > fabs(curMaxAccelZ){
            curMaxAccelZ = acceleration.z
        }
        
        println("X:\(curMaxAccelX) - Y:\(curMaxAccelY) - Z:\(curMaxAccelZ)")
    }
}