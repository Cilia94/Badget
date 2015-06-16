//
//  Makkers Maker
//  Major 4 - Devine Howest
//
//  Eliot Colinet & Cilia Vandenameele
//  Copyright (c) 2015. All rights reserved.

import UIKit
import CoreMotion

class C2UitlegVC: UIViewController {
    
    var motionManager = CMMotionManager()
    var activeView:UIView!
    var freezeView: UIView!
    
    override init(nibName nibNameOrNil:String?, bundle nibBundleOrNil:NSBundle?){
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.activeView = InfoChallenge(naamChallenge: "Strijdmakkers", naamImage: "infoc2")
        self.freezeView = FreezeView(frame: UIScreen.mainScreen().bounds)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellowColor()
        
        self.view = self.activeView
        self.fistbump()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rotated", name: UIDeviceOrientationDidChangeNotification, object: nil)
        
    }
    
    func fistbump() {
        if self.motionManager.deviceMotionAvailable {
            self.motionManager.deviceMotionUpdateInterval = 0.1
            self.motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue()) {
                [weak self] (data: CMDeviceMotion!, error: NSError!) in
                if (data.userAcceleration.x < -1 || data.userAcceleration.x > 1) {
                    println("Acceleration noticed! \(data.userAcceleration.x)")
                    self?.motionManager.stopDeviceMotionUpdates()
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
            if (UIDevice.currentDevice().orientation.rawValue == 3) {
                self.freezeView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
            } else {
                self.freezeView.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI_2))
            }
            self.freezeView.frame = UIScreen.mainScreen().bounds
            self.activeView.addSubview(freezeView)
            
        } else {
            //self.activeView.removeFromSuperview()
            
            // self.activeView = *CUstum UIView van uitlegpagina*
            self.activeView = InfoChallenge(naamChallenge: "Strijdmakkers", naamImage: "infoc2")
            
            self.view.addSubview(self.activeView)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
