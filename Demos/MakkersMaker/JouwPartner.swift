//
//  Makkers Maker
//  Major 4 - Devine Howest
//
//  Eliot Colinet & Cilia Vandenameele
//  Copyright (c) 2015. All rights reserved.

import UIKit

class JouwPartner: UIView {
    
    let partnerLabel:UILabel?
    let ownLabel:UILabel?
    
    
    
    override init(frame: CGRect) {
        
        self.partnerLabel = UILabel(frame: CGRectMake(100, 300, 100, 50))
        
        
        self.ownLabel = UILabel(frame: CGRectMake(100, 500, 100, 50))
        
        
        super.init(frame: frame)
      
        
        let bg = UIImage(named: "BG")
        let bgview = UIImageView(image: bg)
        self.addSubview(bgview)
        
        let header = UIImage(named: "header")
        let headerview = UIImageView(image: header)
        headerview.frame = CGRectMake(-10, 25, header!.size.width, header!.size.height)
        self.addSubview(headerview)
        
        self.partnerLabel!.font = UIFont(name: "DKBlackBamboo", size: 50)
        self.addSubview(self.partnerLabel!)
        self.addSubview(self.ownLabel!)
        
        
        
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
