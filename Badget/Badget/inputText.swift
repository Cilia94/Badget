//
//  inputText.swift
//  Badget
//
//  Created by Cilia Vandenameele on 30-05-15.
//  Copyright (c) 2015 Cilia Vandenameele. All rights reserved.
//

import UIKit

class inputText: UITextField {
    
    convenience init(tekst:String, frame:CGRect ){
        
       
        self.init()
        self.frame = frame
        self.backgroundColor = UIColor.whiteColor()
        
        
        var big = CGFloat(5.0)
        var small = CGFloat(2.0)
        var textField = self
        
        
        var lbl = CAShapeLayer()
        
        lbl.path = UIBezierPath(rect: CGRectMake(-small, -35, 150, 35)).CGPath
        lbl.fillColor = UIColor(red: 0, green: 32/225, blue: 84/225, alpha: 1).CGColor
        self.layer.insertSublayer(lbl, below: textField.layer)
        
        var txtlabel = UILabel(frame: CGRectMake(5, -35, 150, 35))
        txtlabel.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        txtlabel.text = tekst
        txtlabel.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
        txtlabel.textColor = UIColor.whiteColor()
        self.addSubview(txtlabel)
        
        
        
        
        var border = CAShapeLayer()
        border.path = UIBezierPath(rect: CGRectMake(big, textField.frame.size.height, textField.frame.size.width, big)).CGPath
        border.fillColor = UIColor(red: 0, green: 32/225, blue: 84/225, alpha: 1).CGColor
        self.layer.insertSublayer(border, below: textField.layer)
        
        
        var border2 = CAShapeLayer()
        border2.path = UIBezierPath(rect: CGRectMake(0, textField.frame.size.height-small, textField.frame.size.width, small)).CGPath
        border2.fillColor = UIColor(red: 0, green: 32/225, blue: 84/225, alpha: 1).CGColor
        self.layer.insertSublayer(border2, below: textField.layer)
        
        
        
        var border3 = CAShapeLayer()
        border3.path = UIBezierPath(rect: CGRectMake(-small, 0, small, textField.frame.size.height)).CGPath
        border3.fillColor = UIColor(red: 0, green: 32/225, blue: 84/225, alpha: 1).CGColor
        self.layer.insertSublayer(border3, below: textField.layer)
        
        var border4 = CAShapeLayer()
        border4.path = UIBezierPath(rect: CGRectMake(-small, -small, textField.frame.size.width+small, small)).CGPath
        border4.fillColor = UIColor(red: 0, green: 32/225, blue: 84/225, alpha: 1).CGColor
        self.layer.insertSublayer(border4, below: textField.layer)
        
        var border5 = CAShapeLayer()
        border5.path = UIBezierPath(rect: CGRectMake(textField.frame.size.width,0, big, textField.frame.size.height)).CGPath
        border5.fillColor = UIColor(red: 0, green: 32/225, blue: 84/225, alpha: 1).CGColor
        self.layer.insertSublayer(border5, below: textField.layer)
        
        var border6 = CAShapeLayer()
        border6.path = UIBezierPath(rect: CGRectMake(textField.frame.size.width, -small, small, textField.frame.size.height)).CGPath
        border6.fillColor = UIColor(red: 0, green: 32/225, blue: 84/225, alpha: 1).CGColor
        self.layer.insertSublayer(border6, below: textField.layer)
        
        
        textField.layer.masksToBounds = false
        
        

        
        
    }
    
 
    
    func textViewDidBeginEditing(textView: UITextView) {
        println("re")
        if textView.textColor == UIColor.lightGrayColor() {
            textView.text = nil
            textView.textColor = UIColor.blackColor()
        }
    }
    
    
    
//    override init( frame:CGRect?){
//        
//        super.init(frame:frame!)
//  
//        
//        
//        //self.layer.borderColor = UIColor.redColor().CGColor
//        
//        
////        var myColor : UIColor = UIColor( red: 0.5, green: 0.5, blue:0, alpha: 1.0 )
////        myTextField.layer.borderColor = myColor.CGColor
//    }
//
//    required init(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
