//
//  ViewController.swift
//  Challenge2
//
//  Created by Eliot Colinet on 12/06/15.
//  Copyright (c) 2015 Eliot Colinet. All rights reserved.
//

import UIKit
import CoreMotion

class C2UitlegVC: UIViewController {
    
    var motionManager = CMMotionManager()
    var activeView:UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellowColor()
        
        self.activeView = UIView()
        
        self.fistbump()
        
        var label = UILabel(frame: CGRectMake(50, 50, 200, 50))
        label.text = "Just to see"
        self.view.addSubview(label)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rotated", name: UIDeviceOrientationDidChangeNotification, object: nil)
        
    }
    
    func fistbump() {
        if self.motionManager.deviceMotionAvailable {
            self.motionManager.deviceMotionUpdateInterval = 0.1
            self.motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue()) {
                [weak self] (data: CMDeviceMotion!, error: NSError!) in
                if (data.userAcceleration.x < -1 || data.userAcceleration.x > 1) {
                    println("Acceleration noticed! \(data.userAcceleration.x)")
                    var badge2VC = Badge2VC()
                    self!.navigationController?.pushViewController(badge2VC, animated: true)
                }
            }
        } else {
            println("DeviceMotion is not available")
        }
    }
    
    func rotated() {
        println(UIDevice.currentDevice().orientation.rawValue)
        if (UIDevice.currentDevice().orientation.rawValue == 3 || UIDevice.currentDevice().orientation.rawValue == 4){
            self.activeView.removeFromSuperview()
            // self.activeView = *Custum UIView van freezebutton enz...*
            // Gebruik voorbeeld.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
            self.view.addSubview(self.activeView)
            self.view.backgroundColor = UIColor.blueColor()
        } else {
            self.activeView.removeFromSuperview()
            // self.activeView = *CUstum UIView van uitlegpagina*
            self.view.addSubview(self.activeView)
            self.view.backgroundColor = UIColor.yellowColor()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
