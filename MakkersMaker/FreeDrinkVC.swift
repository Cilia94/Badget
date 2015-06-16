//
//  Makkers Maker
//  Major 4 - Devine Howest
//
//  Eliot Colinet & Cilia Vandenameele
//  Copyright (c) 2015. All rights reserved.

import UIKit
import Alamofire

class FreeDrinkVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override init(nibName nibNameOrNil:String?, bundle nibBundleOrNil:NSBundle?){
        
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.view = ProficiatView(frame: UIScreen.mainScreen().bounds)
        
        var label = UILabel(frame: CGRectMake(20, 510, 400, 50))
        label.textColor = UIColor.grayColor()
        label.text = "Schudden na ontvangst van drankje"
        self.view.addSubview(label)
        //var button = pageButton(theViewC: self, titel: "Volgende", targetfunction: "")
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        
        if motion == .MotionShake {
            let reachability = Reachability.reachabilityForInternetConnection()
            if reachability.isReachable() {
                self.navigationController?.pushViewController(Badge1VC(), animated: true)
                // Partner_found -> 1
                self.partnerFound()
            } else {
                self.noInternetAlert()
            }
        }
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

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
