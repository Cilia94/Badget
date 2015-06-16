//
//  Makkers Maker
//  Major 4 - Devine Howest
//
//  Eliot Colinet & Cilia Vandenameele
//  Copyright (c) 2015. All rights reserved.

import UIKit

class Badge1VC: UIViewController {
    
    override init(nibName nibNameOrNil:String?, bundle nibBundleOrNil:NSBundle?){
        
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.view = BadgeView(badge: 1, titel: "Speurneus", uitleg: "Verdiend wegens uitzonderlijk vertoon van moed, uithoudingsvermogen en vindingrijkheid.", image: "badge1")
        var button = pageButton(theViewC: self, titel: "Ik doe mee!", targetfunction: "next")
        
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func nextPage(sender:UIButton!){
        
        navigationController?.pushViewController(C2IntroVC(), animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        NSUserDefaults.standardUserDefaults().setInteger(3, forKey: "lastPage")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
