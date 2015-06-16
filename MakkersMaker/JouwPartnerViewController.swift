//
//  Makkers Maker
//  Major 4 - Devine Howest
//
//  Eliot Colinet & Cilia Vandenameele
//  Copyright (c) 2015. All rights reserved.

import UIKit
import Alamofire

class JouwPartnerViewController: UIViewController {
    
    var theView:JouwPartner {
        get {
            return self.view as! JouwPartner
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        NSUserDefaults.standardUserDefaults().setInteger(3, forKey: "lastPage")
        println("jouw partner vc")
        
        super.init(nibName: nibNameOrNil, bundle:nibBundleOrNil)
        
        self.view = JouwPartner(frame: UIScreen.mainScreen().bounds)
        self.getPartnerName()
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getPartnerName() {
        println("get names")
        let partner_id = NSUserDefaults.standardUserDefaults().integerForKey("partner_id")
        let own_id = NSUserDefaults.standardUserDefaults().integerForKey("id")
        
        Alamofire.request(.GET, "http://student.howest.be/eliot.colinet/20142015/MA4/BADGET/api/users/\(partner_id)").responseJSON{(_,_,data,_) in
            var json = JSON(data!)
            println(NSUserDefaults.standardUserDefaults().integerForKey("partner_id"))
            println("partner name")
            println(json["partner name"])
 
            self.theView.partnerLabel!.text = json["partner name"].stringValue
        }
        
        Alamofire.request(.GET, "http://student.howest.be/eliot.colinet/20142015/MA4/BADGET/api/users/\(own_id)").responseJSON{(_,_,data,_) in
            var json = JSON(data!)
            println(NSUserDefaults.standardUserDefaults().integerForKey("id"))
            println("own name")
            println(json["own name"].stringValue)
            
            self.theView.ownLabel!.text = json["name"].stringValue
        
        }
    }

}
