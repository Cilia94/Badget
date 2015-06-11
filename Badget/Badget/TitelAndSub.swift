//
//  TitelAndSub.swift
//  Badget
//
//  Created by Cilia Vandenameele on 06-06-15.
//  Copyright (c) 2015 Cilia Vandenameele. All rights reserved.
//

import UIKit

class TitelAndSub: UIView {
    
    func attributedString(string text:String, withFont font:UIFont!, kerning: CGFloat!, andColor color:UIColor!) -> NSAttributedString?  {
        return NSAttributedString(string: text, attributes: [NSKernAttributeName:kerning, NSFontAttributeName:font, NSForegroundColorAttributeName:color])
    }
    
    convenience init(titel:String?, subtitel:String){
        
        self.init()
        
        let img = UIImage(named:"titelsub")
        let imgv = UIImageView(image: img)
        self.addSubview(imgv)
        
        
        
        let f1 = UIFont(name: "ManusTrial", size: 40)
        let f2 = UIFont(name: "DKBlackBamboo", size: 40)
        
        let titell = UILabel(frame: CGRectMake(15, 10, 300, 50))
        titell.text = titel
        //attributedString(string: titel!, withFont: f1, kerning: 10.0, andColor: UIColor.whiteColor())
        let first = titel! as NSString
        let bold = "!" as NSString
        let range1 = titel?.rangeOfString(titel!)
        
        
        let full = (first as String) + (bold as String)
        
        var attString = NSMutableAttributedString(string: full)
        
        
        attString.addAttribute(NSFontAttributeName, value: f1!, range: NSMakeRange(0, first.length))
        attString.addAttribute(NSFontAttributeName, value: f2!, range: NSMakeRange(first.length, bold.length))
        
        titell.attributedText = attString
        //titell.font = UIFont(name: "ManusTrial", size: 40)
        titell.textColor = UIColor.whiteColor()
        self.addSubview(titell)
        
        
        let subl = UILabel(frame: CGRectMake(40, 50, 300, 50))
        subl.text = subtitel
        subl.font = UIFont(name: "AvenirNext-MediumItalic", size: 18)
        subl.textColor = UIColor.whiteColor()
        self.addSubview(subl)
        
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    
}
