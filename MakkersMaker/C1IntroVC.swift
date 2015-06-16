//
//  Makkers Maker
//  Major 4 - Devine Howest
//
//  Eliot Colinet & Cilia Vandenameele
//  Copyright (c) 2015. All rights reserved.

import UIKit

class C1IntroVC: UIViewController {
    
    override init(nibName nibNameOrNil:String?, bundle nibBundleOrNil:NSBundle?){
        
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        //self.view = UserInfoView()
        //self.view = InfoChallenge(naamChallenge: "test", naamImage: "infoc1")
        self.view = ConceptView(concept:"concept1", titel:"Makkers Unite", subtitel:"Because 2 is better than 1", uitlegCh: "info over de chllenge vrij lang ook meerdere lijnen label testje lorem ipsummmmm")
        var button = pageButton(theViewC: self, titel: "Ik doe mee!", targetfunction: "next")
        
        println("ViewController")
        
        
    }
    
    
    
    func nextPage(sender:UIButton!)
    {
        println("Button tapped")
        //let infoVC = UserInfoViewController()
        let infoVC = C1UitlegVC(naamChallenge: "Makkers Unite", naamImage: "infoc1");
        
        
        self.navigationController?.pushViewController(infoVC, animated: true)
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("vc view did load")
        let value = UIInterfaceOrientation.LandscapeLeft.rawValue
        UIDevice.currentDevice().setValue(value, forKey: "orientation")
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    required init(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
        
    }
    
    func enumerateFonts(){
        
        for fontFamily in UIFont.familyNames() {
            
            if(fontFamily as! String == "Avenir Next"){
                
                
                println("Font family name = \(fontFamily as! String)");
                for fontName in UIFont.fontNamesForFamilyName(fontFamily
                    as! String) {
                        println("- Font name = \(fontName)");
                }
                println("\n");
            }
        }
    }
    
    
    
}

