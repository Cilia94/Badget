//
//  Badge3VC.swift
//  groepsselfie
//
//  Created by Eliot Colinet on 11/06/15.
//  Copyright (c) 2015 Eliot Colinet. All rights reserved.
//

import UIKit

class Badge3VC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.yellowColor()
        
        self.createButton("Volgende", x: 160, y: 375, w: 75, h: 40, center: true, function: "nextPage")
    }
    
    func nextPage(){
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
        // Dispose of any resources that can be recreated.
    }
    
}