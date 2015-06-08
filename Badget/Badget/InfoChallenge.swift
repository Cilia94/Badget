//
//  InfoChallenge.swift
//  Badget
//
//  Created by Cilia Vandenameele on 06-06-15.
//  Copyright (c) 2015 Cilia Vandenameele. All rights reserved.
//

import UIKit

class InfoChallenge: UIView {
    
    convenience init(naamChallenge:String?, naamImage:String?){
        
        
        self.init();
        
        let bg = UIImage(named: "BG")
        let bgview = UIImageView(image: bg)
        self.addSubview(bgview)
        
        let header = UIImage(named: "header")
        let headerview = UIImageView(image: header)
        headerview.frame = CGRectMake(-10, 25, header!.size.width, header!.size.height)
        self.addSubview(headerview)
        
        let font = UIFont(name: "DKBlackBamboo", size: 30)
        let title = UILabel(frame: CGRectMake(65, 90, 200, 50))
        title.text = naamChallenge
        title.font = font
        title.textColor = UIColor(red: 92/225, green: 135/225, blue: 185/225, alpha: 1)
        
        self.addSubview(title)
        
        var img = UIImage(named: naamImage!)
        var imv = UIImageView(image: img)
        imv.frame = CGRectMake(30, 140, img!.size.width, img!.size.height)
        self.addSubview(imv)
        
        
        
        
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
