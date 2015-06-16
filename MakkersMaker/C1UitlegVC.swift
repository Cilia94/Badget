//
//  Makkers Maker
//  Major 4 - Devine Howest
//
//  Eliot Colinet & Cilia Vandenameele
//  Copyright (c) 2015. All rights reserved.

import UIKit

class C1UitlegVC: UIViewController {
    
    convenience init(naamChallenge:String?, naamImage:String?){
        
        self.init()
        self.view = InfoChallenge(naamChallenge: naamChallenge, naamImage: naamImage)
        var button = pageButton(theViewC: self, titel: "Start!", targetfunction: "next")
        
    }
    
    
    func nextPage(sender:UIButton!) {
        println("Button tapped ConceptViewController")
        
        let loginVC = LoginVC();
        self.navigationController?.pushViewController(loginVC, animated: true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let value = UIInterfaceOrientation.LandscapeLeft.rawValue
        UIDevice.currentDevice().setValue(value, forKey: "orientation")
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}

