//
//  TopBarLabel.swift
//  Badget
//
//  Created by Cilia Vandenameele on 30-05-15.
//  Copyright (c) 2015 Cilia Vandenameele. All rights reserved.
//

import UIKit

class TopBarLabel: UILabel {
    
    convenience init(tekst:String?, tekstBold:String?, frame:CGRect?){
        
        
        self.init(frame:frame!);
        
        
        
        let image = UIImage(named: "RectangleTop")
        let imgview = UIImageView(image: image)
        self.addSubview(imgview)
        
        
        
        let txtView = UITextView(frame: CGRectMake(85, 3, image!.size.width, image!.size.height))
        
        
        let first = tekst! as NSString
        let bold = tekstBold! as NSString
        let range1 = tekst?.rangeOfString(tekst!)
        let f1 = UIFont(name: "AvenirNext-MediumItalic", size: 24)
        let f2 = UIFont(name: "AvenirNext-BoldItalic", size: 24)
        
        let full = (first as String) + " " + (bold as String)
        
        var attString = NSMutableAttributedString(string: full)
        
        
        attString.addAttribute(NSFontAttributeName, value: f1!, range: NSMakeRange(0, first.length))
        attString.addAttribute(NSFontAttributeName, value: f2!, range: NSMakeRange(first.length, bold.length+1))
        
        
        
        
        
        
        txtView.attributedText = attString
        
        //txtView.font = UIFont(name: "Avenir Next", size: 20)
        txtView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        //self.text = tekst
        
        txtView.textColor = UIColor.whiteColor()
        self.addSubview(txtView)
        
    }
    
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    
}
