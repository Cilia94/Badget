//
//  ViewController.swift
//  IOS8SwiftShakeGesureTutorial
//
//  Created by Arthur Knopper on 18/10/14.
//  Copyright (c) 2014 Arthur Knopper. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
  @IBOutlet weak var shakeLabel: UILabel!

    var motionManager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if motionManager.accelerometerAvailable{
            let queue = NSOperationQueue()
            motionManager.startAccelerometerUpdatesToQueue(queue, withHandler:
                {(data: CMAccelerometerData!, error: NSError!) in
                    
                    println("X = \(data.acceleration.x)")
                    println("Y = \(data.acceleration.y)")
                    println("Z = \(data.acceleration.z)")
                    
                }
            )
        } else {
            println("Accelerometer is not available")
        }
        
        if motionManager.deviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.02
            motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue()) {
                [weak self] (data: CMDeviceMotion!, error: NSError!) in
                
                if data.userAcceleration.x < -2.5 {
                    //self?.navigationController?.popViewControllerAnimated(true)
                    println("Acceleration noticed!")
                }
            }
        } else {
            println("DeviceMotion is not available")
        }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func canBecomeFirstResponder() -> Bool {
    return true
  }
  
  override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
    if motion == .MotionShake {
      self.shakeLabel.text = "Shaken, not stirred"
    }
  }
}

