//
//  Makkers Maker
//  Major 4 - Devine Howest
//
//  Eliot Colinet & Cilia Vandenameele
//  Copyright (c) 2015. All rights reserved.

import UIKit

class CheckView: UIView {
    
    var genoegMensen: Bool?
    var uitlegCh: String?
    
    override init(frame:CGRect){
        
        super.init(frame:frame)
        
        let bg = UIImage(named: "BG")
        let bgview = UIImageView(image: bg)
        self.addSubview(bgview)
        
        let header = UIImage(named: "header")
        let headerview = UIImageView(image: header)
        headerview.frame = CGRectMake(-10, 25, header!.size.width, header!.size.height)
        self.addSubview(headerview)
 
        self.uitlegCh = "Upload de foto naar onze website en win de laatste badge!"
        
        if(self.genoegMensen == false){
        
        self.uitlegCh = "Oei, neem een nieuwe foto!"
        }
        
        
        let fnt = UIFont(name: "Helvetica", size: 18)
        
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
