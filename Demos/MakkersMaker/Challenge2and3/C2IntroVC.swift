//
//  Makkers Maker
//  Major 4 - Devine Howest
//
//  Eliot Colinet & Cilia Vandenameele
//  Copyright (c) 2015. All rights reserved.

import UIKit

class C2IntroVC: UIViewController {
    
    
    
    override init(nibName nibNameOrNil:String?, bundle nibBundleOrNil:NSBundle?){
        
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.view = ConceptView(concept:"concept2", titel:"Strijdmakkers", subtitel:"Prepare for battle!", uitlegCh: "Ga samen met het andere team de strijd aan in de ultieme Bierbattle!")
        var button = pageButton(theViewC: self, titel: "Ik doe mee!", targetfunction: "next")
        
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    func enumerateFonts(){
        
        for fontFamily in UIFont.familyNames() {
            
            //if(fontFamily as! String == "Avenir Next"){
                
                
                println("Font family name = \(fontFamily as! String)");
                for fontName in UIFont.fontNamesForFamilyName(fontFamily
                    as! String) {
                        println("- Font name = \(fontName)");
                }
                println("\n");
            }
        //}
    }

    
    func nextPage(sender:UIButton!){
        let uitlegVC = C2UitlegVC(nibName: nil, bundle: nil)
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