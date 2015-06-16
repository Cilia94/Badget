//
//  Makkers Maker
//  Major 4 - Devine Howest
//
//  Eliot Colinet & Cilia Vandenameele
//  Copyright (c) 2015. All rights reserved.

import UIKit

class TrakteerIntroVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.backgroundColor = UIColor.orangeColor()
        
        //self.createButton("Volgende", x: 160, y: 375, w: 75, h: 40, center: true, function: "nextPage")
    }
    
    override init(nibName nibNameOrNil:String?, bundle nibBundleOrNil:NSBundle?){
        
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.view = TrakteerStartView()
        var button = pageButton(theViewC: self, titel: "Trakteren", targetfunction: "next")
        
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func nextPage(sender:UIButton!){
        var uitlegVC = TrakteerUitlegVC()
        navigationController?.pushViewController(uitlegVC, animated: true)
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
        // Dispose of any resources that can be recreated.
    }

}
