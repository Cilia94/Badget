//
//  Makkers Maker
//  Major 4 - Devine Howest
//
//  Eliot Colinet & Cilia Vandenameele
//  Copyright (c) 2015. All rights reserved.

import UIKit
import Alamofire
import CoreMotion

class FreeDrinkVC: UIViewController {

    var allowShake:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSUserDefaults.standardUserDefaults().setInteger(2, forKey: "lastPage")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override init(nibName nibNameOrNil:String?, bundle nibBundleOrNil:NSBundle?){
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.view = ProficiatView(frame: UIScreen.mainScreen().bounds)
        
        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "motion", userInfo: nil, repeats: false)
        
        var label = UILabel(frame: CGRectMake(20, 510, 400, 50))
        label.textColor = UIColor.grayColor()
        label.text = "Schudden na ontvangst van drankje"
        self.view.addSubview(label)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        if (motion == .MotionShake){
            println(self.allowShake)
            if(self.allowShake == true) {
                let reachability = Reachability.reachabilityForInternetConnection()
                if reachability.isReachable() {
                    self.navigationController?.pushViewController(Badge1VC(), animated: true)
                    self.partnerFound()
                    
                } else {
                    self.noInternetAlert()
                }
            }
        }
    }
    
    func motion() {
        self.allowShake = true
    }
    
    func partnerFound() {
        let user_id = NSUserDefaults.standardUserDefaults().integerForKey("user_id")
        
        Alamofire.request(.GET, "http://student.howest.be/eliot.colinet/20142015/MA4/BADGET/api/users/\(user_id)").responseJSON{(_,_,data,_) in
            var json = JSON(data!)
            
            let parameters = [
                "id": NSUserDefaults.standardUserDefaults().integerForKey("user_id"),
                "name": json["name"].stringValue,
                "partner_id": NSUserDefaults.standardUserDefaults().integerForKey("partner_id"),
                "partner_found": 1,
                "fav_stage": json["fav_stage"].stringValue,
                "fav_genre": json["fav_genre"].stringValue
            ]
            
            Alamofire.request(.PUT, "http://student.howest.be/eliot.colinet/20142015/MA4/BADGET/api/users/\(user_id)", parameters: parameters as? [String : AnyObject])
        }
    }
    
    func noInternetAlert() {
        let alert = UIAlertController(
            title: "GEEN INTERNET",
            message: "Gelieve uw internetverbinding in te schakelen",
            preferredStyle: UIAlertControllerStyle.Alert
        )
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action) -> Void in
            // Code
        }
        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }

}
