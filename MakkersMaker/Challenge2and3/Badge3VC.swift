//
//  Makkers Maker
//  Major 4 - Devine Howest
//
//  Eliot Colinet & Cilia Vandenameele
//  Copyright (c) 2015. All rights reserved.

import UIKit

class Badge3VC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSUserDefaults.standardUserDefaults().setInteger(5, forKey: "lastPage")
    }
    
    override init(nibName nibNameOrNil:String?, bundle nibBundleOrNil:NSBundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.view = BadgeView(badge: 3, titel: "Fotomodel", uitleg: "Verdiend wegens vertoon van opmerkelijke groepsspirit! Je kan nu je goodie gaan afhalen", image: "badge3")
        var button = pageButton(theViewC: self, titel: "Trakteer app", targetfunction: "next")
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func nextPage(sender:UIButton!){
        var trakteerVC = TrakteerIntroVC()
        navigationController?.pushViewController(trakteerVC, animated: true)
    }
    
    func createButton(btnTitle:String, x:Int, y:Int, w:Int, h:Int, center:Bool, function:String){
        
        let button = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        button.setTitle(btnTitle, forState: UIControlState.Normal)
        button.frame = CGRect(x: x, y: y, width: w, height: h)
        if (center == true){
            button.center = CGPoint(x: x, y: y )
        }
        self.view.addSubview(button)
        
        button.addTarget(self, action: Selector(function), forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}