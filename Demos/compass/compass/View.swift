//
//  View.swift
//  GestureFun
//
//  Created by Frederik Jacques on 02/03/15.
//  Copyright (c) 2015 Frederik Jacques. All rights reserved.
//

import UIKit

class View: UIView {

    let imageView:UIImageView
    
    override init(frame: CGRect) {
        
        self.imageView = UIImageView(frame: CGRectMake(0, 0, 200, 200))
        
        super.init(frame: frame)
        
        self.imageView.image = UIImage(named: "compass")
    
        self.imageView.center = self.center;
        self.addSubview(self.imageView)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
