//
//  Makkers Maker
//  Major 4 - Devine Howest
//
//  Eliot Colinet & Cilia Vandenameele
//  Copyright (c) 2015. All rights reserved.

import UIKit
import AudioToolbox

class FreezeView: UIView {

    var counter:UILabel?
    var buzzTimer:NSTimer?
    var timeRemaining: Int?

    
    override init(frame:CGRect){
        
        super.init(frame:frame)
        self.freezeMe()
        
    }
    
    func freezeMe(){
        
        if(self.buzzTimer != nil){
            self.buzzTimer!.invalidate()
        }
        
        let bg = UIImage(named: "BG")
        let bgview = UIImageView(image: bg)
        let bgview2 = UIImageView(image: bg)
        bgview2.frame = CGRectMake(bg!.size.width, 0, bg!.size.width, bg!.size.height)
        
        self.addSubview(bgview)
        self.addSubview(bgview2)

        let img = UIImage(named: "freezeMe")
        let imgv = UIImageView(image: img)
        
        let btn = UIButton(frame: CGRectMake(50, 0, img!.size.width, img!.size.height))
        btn.addSubview(imgv)
        btn.addTarget(self, action: "frozen", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(btn)
        
    }
    
    func frozen(){
        self.timeRemaining = 10;
        var timer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: Selector("freezeMe"), userInfo: nil, repeats: false)
        self.buzzTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("buzz"), userInfo: nil, repeats: true)
       

        let bg = UIImage(named: "bgFrozen")
        let bgview = UIImageView(image: bg)
        self.addSubview(bgview)
        
        
        let lbl = UILabel(frame: CGRectMake(175, 50, 300, 100))
        lbl.text = "Frozen"
        lbl.font = UIFont(name: "DKBlackBamboo", size: 100)
        lbl.textColor = UIColor.whiteColor()
        self.addSubview(lbl)
        
        self.counter = UILabel(frame: CGRectMake(110, 160, 550, 80))
        self.counter!.text = "10 seconden"
        self.counter!.font = UIFont(name: "DKBlackBamboo", size: 80)
        self.counter!.textColor = UIColor.whiteColor()
        self.addSubview(self.counter!)

    }
    
    func buzz(){
        
         AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        self.timeRemaining!--;
         self.counter!.text = String(self.timeRemaining!) + " seconden"
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
