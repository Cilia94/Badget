//
//  ConceptViewController.swift
//  Badget
//
//  Created by Cilia Vandenameele on 06-06-15.
//  Copyright (c) 2015 Cilia Vandenameele. All rights reserved.
//

import UIKit

class ConceptViewController: UIViewController {
    
    convenience init(naamChallenge:String?, naamImage:String?){
        
        self.init()
        self.view = InfoChallenge(naamChallenge: naamChallenge, naamImage: naamImage)
        var button = pageButton(theViewC: self, titel: "Start!", targetfunction: "next")
        
    }
    
    
    func nextPage(sender:UIButton!)
    {
        println("Button tapped")
        let infoVC = Challenge1ViewController();
        //let infoVC = UserInfoViewController();
        self.navigationController?.pushViewController(infoVC, animated: true)
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let value = UIInterfaceOrientation.LandscapeLeft.rawValue
        UIDevice.currentDevice().setValue(value, forKey: "orientation")
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
//    required init(coder aDecoder: NSCoder) {
//        
//        fatalError("init(coder:) has not been implemented")
//        
//        
//    }
    
    



}

