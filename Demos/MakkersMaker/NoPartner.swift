//
//  Makkers Maker
//  Major 4 - Devine Howest
//
//  Eliot Colinet & Cilia Vandenameele
//  Copyright (c) 2015. All rights reserved.

import UIKit

class NoPartner: UIView {
    
    override init(frame:CGRect?)
    {
        
        super.init(frame:frame!)
        
        //self.scrolly()
        
        //view.backgroundColor = UIColor.redColor()
        
        let bg = UIImage(named: "BG")
        let bgview = UIImageView(image: bg)
        self.addSubview(bgview)
        
        let header = UIImage(named: "header")
        let headerview = UIImageView(image: header)
        headerview.frame = CGRectMake(-10, 25, header!.size.width, header!.size.height)
        self.addSubview(headerview)
        
        
        let kad = UIImage(named: "kader-bottom")
        let kadv = UIImageView(image: kad)
        kadv.frame = CGRectMake(20, 150, kad!.size.width, kad!.size.height)
        //self.view.addSubview(kadv)
        
        let head = UIImage(named: "pinkBg")
        let headv = UIImageView(image: head)
        headv.frame = CGRectMake(20, 50, head!.size.width, head!.size.height)
        //self.addSubview(headv)
        
        //view.backgroundColor = UIColor(patternImage: UIImage(named: imageFile)!)
        
        let label = UILabel(frame: CGRectMake(70, 280, 250, 80))
        //label.textColor = UIColor.whiteColor()
        label.text = "Sorry..."
        label.textColor = UIColor(red: 242/225, green: 133/225, blue: 141/225, alpha: 1)
        
        label.font = UIFont(name: "DKBlackBamboo", size: 65)
        
        //label.textAlignment = .Center
       self.addSubview(label)
        
        let blik = UIImage(named: "notFound")
        let blikv = UIImageView(image: blik)
        blikv.frame = CGRectMake(30, 100, blik!.size.width, blik!.size.height)
        self.addSubview(blikv)
        
        
        
        let font = UIFont(name: "Helvetica", size: 15)
        let infoText = "Je makker is momenteel nog een pintje aan het drinken"
        let infostring = infoText as NSString
        let boundingBox = infostring.boundingRectWithSize(CGSizeMake(230,
            CGFloat.max), options:
            NSStringDrawingOptions.UsesLineFragmentOrigin, attributes:
            [NSFontAttributeName:font!], context: nil)
        
        let info = UILabel(frame: CGRectMake(50, 355,
            boundingBox.size.width, boundingBox.size.height))
        info.text = infoText
        info.textColor = UIColor(red: 242/225, green: 133/225, blue: 141/225, alpha: 1)
        info.textAlignment = NSTextAlignment.Center
        //info.sizeToFit()
        info.font =  UIFont(name: "Helvetica", size: 15)
        
        info.numberOfLines = 0
        self.addSubview(info)
        
        
        //let font = UIFont(name: "Helvetica", size: 20)
        let infoText2 = "We blijven zoeken, nog even geduld!"
        let infostring2 = infoText2 as NSString
        let boundingBox2 = infostring2.boundingRectWithSize(CGSizeMake(230,
            CGFloat.max), options:
            NSStringDrawingOptions.UsesLineFragmentOrigin, attributes:
            [NSFontAttributeName:font!], context: nil)
        
        let info2 = UILabel(frame: CGRectMake(50, 415,
            boundingBox2.size.width, boundingBox.size.height))
        info2.text = infoText2
        info2.textColor = UIColor(red: 242/225, green: 133/225, blue: 141/225, alpha: 1)
        info2.textAlignment = NSTextAlignment.Center
        //info.sizeToFit()
        info2.font =  UIFont(name: "Helvetica", size: 15)
        
        info2.numberOfLines = 0
        self.addSubview(info2)
        
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
