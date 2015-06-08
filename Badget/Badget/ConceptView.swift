//
//  ConceptView.swift
//  Badget
//
//  Created by Cilia Vandenameele on 06-06-15.
//  Copyright (c) 2015 Cilia Vandenameele. All rights reserved.
//

import UIKit

class ConceptView: UIView {
    
    convenience init(concept:String?, titel:String?, subtitel:String?){
        
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
        imgview.frame = CGRectMake(-60, 90, img!.size.width, img!.size.height)
        self.addSubview(imgview)
        
        
        let f = TitelAndSub(titel: titel!, subtitel: subtitel!)
        f.frame = CGRectMake(20, 325, 230, 100)
        self.addSubview(f)

    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
