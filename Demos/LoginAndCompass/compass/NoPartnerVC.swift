//
//  NoPartnerVC.swift
//  compass
//
//  Created by Eliot Colinet on 08/06/15.
//  Copyright (c) 2015 Eliot Colinet. All rights reserved.
//

import UIKit

class NoPartnerVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NSUserDefaults.standardUserDefaults().setInteger(-1, forKey: "lastPage")
        
        self.view.backgroundColor = UIColor.orangeColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
