//
//  NoPartnerVC.swift
//  compass
//
//  Created by Eliot Colinet on 08/06/15.
//  Copyright (c) 2015 Eliot Colinet. All rights reserved.
//

import UIKit
import Alamofire

class NoPartnerVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NSUserDefaults.standardUserDefaults().setInteger(-1, forKey: "lastPage")
        
        self.view.backgroundColor = UIColor.orangeColor()
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "checkIfFoundPartner", userInfo: nil, repeats: true)
    }
    
    func checkIfFoundPartner() {
        
        if (NSUserDefaults.standardUserDefaults().integerForKey("partner_id") == 0) {
            println("Checking for partner!")
            
            var user_id = NSUserDefaults.standardUserDefaults().integerForKey("user_id")
            
            Alamofire.request(.GET, "http://student.howest.be/eliot.colinet/20142015/MA4/BADGET/api/users/\(user_id)").responseJSON{(_,_,data,_) in
                var json = JSON(data!)
                
                if (json["partner_id"].intValue != 0) {
                    self.createUserLocation()
                        
                    NSUserDefaults.standardUserDefaults().setInteger(json["partner_id"].intValue, forKey: "partner_id")
                    NSUserDefaults.standardUserDefaults().synchronize()
                        
                    let compass = CompassVC();
                    self.navigationController?.pushViewController(compass, animated: true)
                }
                
            }
        }
    }
    
    func createUserLocation(){
        
        let parameters = [
            "id": "",
            "user_id": NSUserDefaults.standardUserDefaults().integerForKey("user_id"),
            "latitude": "",
            "longitude": ""
        ]
        
        Alamofire.request(.POST, "http://student.howest.be/eliot.colinet/20142015/MA4/BADGET/api/locations", parameters: parameters as? [String : AnyObject]).responseJSON{(_,_,data,_) in
            var json = JSON(data!)
            
            NSUserDefaults.standardUserDefaults().setInteger(json["id"].intValue, forKey: "loc_id")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
