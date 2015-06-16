//
//  Makkers Maker
//  Major 4 - Devine Howest
//
//  Eliot Colinet & Cilia Vandenameele
//  Copyright (c) 2015. All rights reserved.

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
        
        let topk = UIImage(named: "kader-top")
        let topkview = UIImageView(image: topk)
        topkview.frame = CGRectMake(20, 95, topk!.size.width, topk!.size.height)
        self.addSubview(topkview)
        
        
        let font = UIFont(name: "DKBlackBamboo", size: 25)
        let title = UILabel(frame: CGRectMake(65, 85, 200, 50))
        title.text = naamChallenge
        title.font = font
        title.textColor = UIColor(red: 73/225, green: 118/225, blue: 171/225, alpha: 1)
        title.textAlignment = NSTextAlignment.Center
        self.addSubview(title)
        
        var img = UIImage(named: naamImage!)
        var imv = UIImageView(image: img)
        
        if(naamImage! == "infoc2"){
          imv.frame = CGRectMake(30, 130, img!.size.width, img!.size.height)
        }else{
        imv.frame = CGRectMake(30, 110, img!.size.width, img!.size.height)
        }
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
