//
//  Makkers Maker
//  Major 4 - Devine Howest
//
//  Eliot Colinet & Cilia Vandenameele
//  Copyright (c) 2015. All rights reserved.

import UIKit

class ConceptView: UIView {
    
    convenience init(concept:String?, titel:String?, subtitel:String?, uitlegCh:String?){
        
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
        topkview.frame = CGRectMake(20, 110, topk!.size.width, topk!.size.height)
        self.addSubview(topkview)
        
        let img = UIImage(named: concept!)
        let imgview = UIImageView(image: img)
        println(img!.description)
        
        switch concept!{
            case "concept1":
            imgview.frame = CGRectMake(-60, 90, img!.size.width, img!.size.height)
            
            case "concept2":
            imgview.frame = CGRectMake(0, 100, img!.size.width, img!.size.height)
            
            case "concept3":
            imgview.frame = CGRectMake(0, 125, img!.size.width, img!.size.height)
            
        default:
            imgview.frame = CGRectMake(0, 100, img!.size.width, img!.size.height)
            
        }
       
        self.addSubview(imgview)
        
        
        let f = TitelAndSub(titel: titel!, subtitel: subtitel!)
        f.frame = CGRectMake(20, 325, 230, 100)
        self.addSubview(f)
        
        
        let uitlegCh = uitlegCh
        
        let fnt = UIFont(name: "Helvetica", size: 15)
        
        let infostring = uitlegCh! as NSString
        let boundingBox = infostring.boundingRectWithSize(CGSizeMake(230,
            CGFloat.max), options:
            NSStringDrawingOptions.UsesLineFragmentOrigin, attributes:
            [NSFontAttributeName:fnt!], context: nil)
        
        let info = UILabel(frame: CGRectMake(50, 425,
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
