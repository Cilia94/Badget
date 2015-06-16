//
//  Makkers Maker
//  Major 4 - Devine Howest
//
//  Eliot Colinet & Cilia Vandenameele
//  Copyright (c) 2015. All rights reserved.

import UIKit

class pageButton: UIButton {

    var button: UIButton?
    
    
    convenience init( theViewC:UIViewController, titel:String?, targetfunction:String){
        
        self.init()
   
        self.button  = UIButton.buttonWithType(UIButtonType.System) as? UIButton
        
        let bgimg = UIImage(named: "button")
        let bg = UIImageView(image: bgimg)
        button!.frame = CGRectMake(65, 500, bgimg!.size.width, bgimg!.size.height)


        button!.addSubview(bg)
        button!.setTitle(titel, forState: UIControlState.Normal)
        button!.titleLabel?.font = UIFont(name: "AvenirNextCondensed-DemiBoldItalic", size: 30)
        
        button!.addTarget(theViewC, action: "nextPage:", forControlEvents: UIControlEvents.TouchUpInside)
        button!.setTitleColor(UIColor(red: 65/225, green: 111/225, blue: 164/225, alpha: 1), forState: UIControlState.Normal)

       
        theViewC.view.addSubview(button!)


    }

}
