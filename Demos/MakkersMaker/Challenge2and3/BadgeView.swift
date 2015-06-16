//
//  Makkers Maker
//  Major 4 - Devine Howest
//
//  Eliot Colinet & Cilia Vandenameele
//  Copyright (c) 2015. All rights reserved.

import UIKit

class BadgeView: UIView {
    
    convenience init(badge:Int?, titel:String?, uitleg:String?, image:String?){
        
        self.init()
        
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
        let title = UILabel(frame: CGRectMake(95, 80, 200, 50))
        title.text = titel
        title.font = font
        title.textColor = UIColor(red: 73/225, green: 118/225, blue: 171/225, alpha: 1)
        
        self.addSubview(title)

        
        let img = UIImage(named: image!)
        let imgview = UIImageView(image: img)
        //println(img!.description)
   
        imgview.frame = CGRectMake(0, 120, img!.size.width, img!.size.height)
        self.addSubview(imgview)
        
        switch badge!{
            
        case 1:
            
            let imgb = UIImage(named: "badgeprogress1")
            let imgbview = UIImageView(image: imgb)
            imgbview.frame = CGRectMake(30, 460, imgb!.size.width, imgb!.size.height)
            self.addSubview(imgbview)
            
        case 2:
            
            let imgb = UIImage(named: "badgeprogress2")
            let imgbview = UIImageView(image: imgb)
            imgbview.frame = CGRectMake(30, 460, imgb!.size.width, imgb!.size.height)
            self.addSubview(imgbview)
            
        case 3:
            
            let imgb = UIImage(named: "badgeprogress3")
            let imgbview = UIImageView(image: imgb)
            imgbview.frame = CGRectMake(30, 460, imgb!.size.width, imgb!.size.height)
            self.addSubview(imgbview)
            
        default:
            
            let imgb = UIImage(named: "badgeprogress1")
            let imgbview = UIImageView(image: imgb)
            imgbview.frame = CGRectMake(30, 460, imgb!.size.width, imgb!.size.height)
            self.addSubview(imgbview)
            
            
            
        }
        
        
        
        
        let uitlegCh = uitleg
        
        let fnt = UIFont(name: "Helvetica", size: 15)
        
        let infostring = uitlegCh! as NSString
        let boundingBox = infostring.boundingRectWithSize(CGSizeMake(240,
            CGFloat.max), options:
            NSStringDrawingOptions.UsesLineFragmentOrigin, attributes:
            [NSFontAttributeName:fnt!], context: nil)
        
        let info = UILabel(frame: CGRectMake(50, 375,
            boundingBox.size.width, boundingBox.size.height))
        info.text = uitlegCh!
        info.textColor = UIColor(red: 242/225, green: 133/225, blue: 141/225, alpha: 1)
        //println(info.text)
        //info.sizeToFit()
        info.font =  fnt
        info.textAlignment = NSTextAlignment.Center
        
        info.numberOfLines = 0
        self.addSubview(info)

        
        
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
