//
//  Makkers Maker
//  Major 4 - Devine Howest
//
//  Eliot Colinet & Cilia Vandenameele
//  Copyright (c) 2015. All rights reserved.


import UIKit

class Challenge1View: UIView {
    
    let imageView:UIImageView
    var counter:UILabel
    var fillValue:Float?
    var distanceValue:Int?
    var nameP:UILabel?
    
    override init(frame: CGRect) {
        
        self.imageView = UIImageView(frame: CGRectMake(80, 115, 138+25, 241+40))
        self.counter = UILabel(frame: CGRectMake(60, 405, 80, 40))
        self.distanceValue = 15
        super.init(frame: frame)
        
        let bg = UIImage(named: "BG")
        let bgview = UIImageView(image: bg)
        self.addSubview(bgview)
        
        let header = UIImage(named: "header")
        let headerview = UIImageView(image: header)
        headerview.frame = CGRectMake(-10, 25, header!.size.width, header!.size.height)
        self.addSubview(headerview)
        
        self.imageView.image = UIImage(named: "wijzer")
        
        let blik = UIImage(named: "blik")
        let blikv = UIImageView(image: blik!)
        blikv.frame = CGRectMake(40, 120, blik!.size.width, blik!.size.height)
        self.addSubview(blikv)
        
        //self.imageView.center = self.center;
        self.addSubview(self.imageView)
        
        let dis = UIImage(named: "afstandbg")
        let disview = UIImageView(image: dis)
        disview.frame = CGRectMake(50, 400, dis!.size.width, dis!.size.height)
        self.addSubview(disview)
        
        let glass = UIImage(named: "glas")
        let glassview = UIImageView(image: glass)
        glassview.frame = CGRectMake(180, 350, glass!.size.width/2, glass!.size.height/2)
        self.addSubview(glassview)
        
        
        
        self.nameP = UILabel(frame: CGRectMake(70, 457, 150, 30))
        self.nameP!.text = "LONGNAME"
        self.nameP!.textColor = UIColor.whiteColor()
        
        self.addSubview(self.nameP!)
        
    }
    
    func glassFill( distance:Double ){
        
        let glass = UIImage(named: "glas")
        let glassview = UIImageView(image: glass)
        glassview.frame = CGRectMake(180, 350, glass!.size.width/2, glass!.size.height/2)
        self.addSubview(glassview)
        
        let glassfill = UIImage(named: "glassfill")
        //let glassfillview = UIImageView(image: glassfill)
        //glassfillview.frame = CGRectMake(180, 350, glassfill!.size.width/2, glassfill!.size.height/2)
        
        let glasslayer = CALayer()
        glasslayer.contents = glassfill?.CGImage
        glasslayer.bounds = CGRectMake(0, 0, glassfill!.size.width/2, glassfill!.size.height/2)
        glasslayer.position.x = 180 + glassfill!.size.width/4
        glasslayer.position.y = 350 + glassfill!.size.height/4
        
        
        
        //self.addSubview(glassfillview)
        
        var maskl = CAShapeLayer()
        
        switch distance {
            
        case 0...25:
            
            maskl.path = UIBezierPath(rect: CGRectMake(0, 60 , glass!.size.width/2, glass!.size.height/2)).CGPath
            
        case 25...50:
            maskl.path = UIBezierPath(rect: CGRectMake(0, 85 , glass!.size.width/2, glass!.size.height/2)).CGPath
            
        case 50...100:
            maskl.path = UIBezierPath(rect: CGRectMake(0, 110 , glass!.size.width/2, glass!.size.height/2)).CGPath
            
        case 100...200:
            maskl.path = UIBezierPath(rect: CGRectMake(0, 130 , glass!.size.width/2, glass!.size.height/2)).CGPath
            
        case 200...500:
            maskl.path = UIBezierPath(rect: CGRectMake(0, 150 , glass!.size.width/2, glass!.size.height/2)).CGPath
            
        default:
            maskl.path = UIBezierPath(rect: CGRectMake(0, 170 , glass!.size.width/2, glass!.size.height/2)).CGPath
            
        }
        //maskl.path = UIBezierPath(rect: CGRectMake(0, 170 , glass!.size.width/2, glass!.size.height/2)).CGPath
        maskl.fillColor = UIColor.whiteColor().CGColor
        
        self.layer.addSublayer(glasslayer)
        //self.layer.addSublayer(maskl)
        glasslayer.mask = maskl
        //self.layer.addSublayer(glasslayer)
        
        
        //self.counter.backgroundColor = UIColor.redColor()
        //self.counter = UILabel(frame: CGRectMake(60, 400, 100, 30))
        self.counter.text = "Afstand"
        self.counter.textColor = UIColor.whiteColor()
        self.addSubview(self.counter)
        
        
    }
    
    func showInfo() {
        
    }
    
    func showGIF() {
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
