//
//  StartView.swift
//  Badget
//
//  Created by Cilia Vandenameele on 28-05-15.
//  Copyright (c) 2015 Cilia Vandenameele. All rights reserved.
//

import UIKit

class UserInfoView: UIView {
    
    var nameInput:UITextField?
    
    
    
    override init(frame: CGRect) {
        
        let bg = UIImage(named: "BG")
        let bgview = UIImageView(image: bg)
        
        //self.backgroundColor = UIColor.blackColor()
        
        let header = UIImage(named: "header")
        let headerview = UIImageView(image: header)
        headerview.frame = CGRectMake(-10, 25, header!.size.width, header!.size.height)
        
        
        
        let imgtxt = UIImage(named: "inputBox")
        let imgtxtv = UIImageView(image: imgtxt)
        imgtxtv.frame = CGRectMake(50, 170, imgtxt!.size.width, imgtxt!.size.height)
        
        var label = UILabel(frame: CGRectMake(67 ,150, imgtxt!.size.width, imgtxt!.size.height))
        label.text = "Jouw naam"
        label.textColor = UIColor.whiteColor()
        
        let topk = UIImage(named: "kader-top")
        let topkview = UIImageView(image: topk)
        topkview.frame = CGRectMake(20, 110, topk!.size.width, topk!.size.height)
        
        
        
        let lbl = UILabel(frame: CGRectMake(90, 95, 200, 40))
        lbl.text = "Jouw info"
        lbl.font = UIFont(name: "DKBlackBamboo", size: 30)
        lbl.textColor = UIColor(red: 61/225, green: 107/225, blue: 160/225, alpha: 1)
        
        self.nameInput = UITextField(frame: CGRectMake(60, 200,imgtxt!.size.width-15, 35))
        self.nameInput!.backgroundColor = UIColor.whiteColor()
        self.nameInput!.placeholder = "Name..."
        
        super.init(frame: frame)
        
        
        self.addSubview(bgview)
        self.addSubview(headerview)
        self.addSubview(imgtxtv)
        self.addSubview(label)
        self.addSubview(self.nameInput!)
        self.addSubview(topkview)
        self.addSubview(lbl)
        
        println("yep")
        
        let imggenre = UIImage(named: "inputGenre")
        let imggenrev = UIImageView(image: imggenre)
        imggenrev.frame = CGRectMake(50, 270, imggenre!.size.width, imggenre!.size.height)
        self.addSubview(imggenrev)
        var label2 = UILabel(frame: CGRectMake(67 ,250, imggenre!.size.width, imggenre!.size.height))
        label2.text = "Jouw genre"
        label2.textColor = UIColor.whiteColor()
        self.addSubview(label2)
        
        //        var genreInput = UITextField(frame: CGRectMake(60, 330, imggenre!.size.width-15, 35))
        //        genreInput.backgroundColor = UIColor.whiteColor()
        //        self.addSubview(genreInput)
        
        let imgstage = UIImage(named: "inputGenre")
        let imgstagev = UIImageView(image: imgstage)
        imgstagev.frame = CGRectMake(50, 370, imgstage!.size.width, imgstage!.size.height)
        self.addSubview(imgstagev)
        var label3 = UILabel(frame: CGRectMake(67 ,390, imggenre!.size.width, imggenre!.size.height))
        label3.text = "Jouw stage"
        label3.textColor = UIColor.whiteColor()
        self.addSubview(label3)
        
        //        var stageInput = UITextField(frame: CGRectMake(60, 330, imgstage!.size.width-15, 35))
        //        stageInput.backgroundColor = UIColor.whiteColor()
        //        self.addSubview(stageInput)
        
        
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        self.addGestureRecognizer(tap)
        
        
        
        
        
        //self.backgroundColor = UIColor.blueColor()
    }
    
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        self.endEditing(true)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    
}
