//
//  Makkers Maker
//  Major 4 - Devine Howest
//
//  Eliot Colinet & Cilia Vandenameele
//  Copyright (c) 2015. All rights reserved.

import UIKit

class NavViewController: UINavigationController {
    
    

//    override func shouldAutorotate() -> Bool {
//        return false
//    }
    
//    override init(rootViewController: View) {
//        //let mainvC = ViewController(nibName: nil, bundle: nil)
//        
//        
//        super.init(rootViewController: rootViewController)
//        
//        let bg = UIImage(named: "BG")
//        let bgview = UIImageView(image: bg)
//        self.view!.addSubview(bgview)
//        
//        let header = UIImage(named: "header")
//        let headerview = UIImageView(image: header)
//        headerview.frame = CGRectMake(-10, 25, header!.size.width, header!.size.height)
//        self.view!.addSubview(headerview)
//
//        
//        
//    }
    
//        
//    override func loadView() {
//        
//        let bg = UIImage(named: "BG")
//        let bgview = UIImageView(image: bg)
//        self.view!.addSubview(bgview)
//        
//        let header = UIImage(named: "header")
//        let headerview = UIImageView(image: header)
//        headerview.frame = CGRectMake(-10, 25, header!.size.width, header!.size.height)
//        self.view!.addSubview(headerview)
//        
//        
//    }
    

//    required init(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    
    
    
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view!.addSubview(view: UIView)


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    


}
