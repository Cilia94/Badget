//
//  NavViewController.swift
//  Badget
//
//  Created by Cilia Vandenameele on 29-05-15.
//  Copyright (c) 2015 Cilia Vandenameele. All rights reserved.
//

import UIKit

class NavViewController: UINavigationController {
    

//    override func shouldAutorotate() -> Bool {
//        return false
//    }
    
    
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    


}
