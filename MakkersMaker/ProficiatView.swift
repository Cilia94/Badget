//
//  Makkers Maker
//  Major 4 - Devine Howest
//
//  Eliot Colinet & Cilia Vandenameele
//  Copyright (c) 2015. All rights reserved.

import UIKit

class ProficiatView: UIView {

    
    override init(frame: CGRect) {
        
        
        super.init(frame: frame)
        
        let bg = UIImage(named: "BG")
        let bgview = UIImageView(image: bg)
        self.addSubview(bgview)
        
        let header = UIImage(named: "header")
        let headerview = UIImageView(image: header)
        headerview.frame = CGRectMake(-10, 25, header!.size.width, header!.size.height)
        self.addSubview(headerview)
        
        
        let img = UIImage(named: "proficiat")
        let imgv = UIImageView(image: img)
        imgv.frame = CGRectMake(-60, 100, img!.size.width, img!.size.height)
        self.addSubview(imgv)
        
        let label = UILabel(frame: CGRectMake(30, 350, 300, 80))
        //label.textColor = UIColor.whiteColor()
        label.text = "Proficiat!"
        label.textColor = UIColor(red: 242/225, green: 133/225, blue: 141/225, alpha: 1)
        
        label.font = UIFont(name: "DKBlackBamboo", size: 65)
        
        //label.textAlignment = .Center
        self.addSubview(label)
        
        
        
                let uitlegCh = "Jij en je makker kunnen nu naar de Maes stand gaan voor een gratis drankje."
        
                let fnt = UIFont(name: "Helvetica", size: 15)
        
                let infostring = uitlegCh as NSString
                let boundingBox = infostring.boundingRectWithSize(CGSizeMake(230,
                    CGFloat.max), options:
                    NSStringDrawingOptions.UsesLineFragmentOrigin, attributes:
                    [NSFontAttributeName:fnt!], context: nil)
        
                let info = UILabel(frame: CGRectMake(50, 425,
                    boundingBox.size.width, boundingBox.size.height))
                info.text = uitlegCh
                info.textColor = UIColor(red: 242/225, green: 133/225, blue: 141/225, alpha: 1)
                //println(info.text)
                //info.sizeToFit()
                info.font =  fnt
                info.textAlignment = NSTextAlignment.Center
        
                info.numberOfLines = 0
                self.addSubview(info)
        
        
        
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
