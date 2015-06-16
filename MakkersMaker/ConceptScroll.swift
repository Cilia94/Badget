//
//  Makkers Maker
//  Major 4 - Devine Howest
//
//  Eliot Colinet & Cilia Vandenameele
//  Copyright (c) 2015. All rights reserved.

import UIKit

class ConceptScroll: UIViewController {
    
    var pageIndex : Int = 0
    var titleText : String = "test"
    var imageFile : String = "kader-bottom"
    var infoText : String = "info"
    var bgHeader : String = "pinkBg"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let kad = UIImage(named: "kader-bottom")
        let kadv = UIImageView(image: kad)
        kadv.frame = CGRectMake(20, 150, kad!.size.width, kad!.size.height)
        self.view.addSubview(kadv)
        
        let head = UIImage(named: "pinkBg")
        let headv = UIImageView(image: head)
        headv.frame = CGRectMake(20, 50, head!.size.width, head!.size.height)
        self.view.addSubview(headv)

        let label = UILabel(frame: CGRectMake(80, 60, view.frame.width, 50))
        label.text = titleText
        view.addSubview(label)
        
        let font = UIFont(name: "AvenirNext-MediumItalic", size: 20)

        let infostring = infoText as NSString
        let boundingBox = infostring.boundingRectWithSize(CGSizeMake(230,
            CGFloat.max), options:
            NSStringDrawingOptions.UsesLineFragmentOrigin, attributes:
            [NSFontAttributeName:font!], context: nil)
        
        let info = UILabel(frame: CGRectMake(50, 145,
                boundingBox.size.width, boundingBox.size.height))
        info.text = infoText
        info.textColor = UIColor(red: 242/225, green: 133/225, blue: 141/225, alpha: 1)
        
        info.font =  UIFont(name: "AvenirNext-MediumItalic", size: 20)

        info.numberOfLines = 0
        self.view.addSubview(info)
        
    }

    func scrolly(){
        
        let titles = ["Matchen", "Challenges", "New Friends"]
        let infos = ["Met jouw info zoeken we je perfecte makker"]
        
        
        let head = UIImage(named: "pinkBg")
        let headv = UIImageView(image: head)
        headv.frame = CGRectMake(20, 305, head!.size.width, head!.size.height)
        self.view.addSubview(headv)
        
        let title = UILabel(frame: CGRectMake(100, 305, head!.size.width, head!.size.height))
        title.text = titles[0]
        self.view.addSubview(title)
        
        let font = UIFont(name: "Helvetica", size: 20)
        
        let infostring = infos[0] as NSString
        let boundingBox = infostring.boundingRectWithSize(CGSizeMake(250,
            CGFloat.max), options:
            NSStringDrawingOptions.UsesLineFragmentOrigin, attributes:
            [NSFontAttributeName:font!], context: nil)
      
        let info = UILabel(frame: CGRectMake(50, 375,
                boundingBox.size.width, boundingBox.size.height))
        info.text = infos[0]
        info.textColor = UIColor.blackColor()
        info.numberOfLines = 0
        self.view.addSubview(info)
    }
    
}
