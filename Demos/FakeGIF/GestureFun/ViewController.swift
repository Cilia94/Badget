//
//  ViewController.swift
//  GestureFun
//
//  Created by Frederik Jacques on 02/03/15.
//  Copyright (c) 2015 Frederik Jacques. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var theView:View {
        get {
            return self.view as! View
        }
    }
    
    let fileNames:Array<String>
    var currentFileNameIndex:Int = 0 {
        
        didSet {
           
            self.currentFileNameIndex = min(max(self.currentFileNameIndex, 0), fileNames.count - 1)
                        
            self.theView.update( fileNames[currentFileNameIndex] )

        }
        
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        
        self.fileNames = ["cute-kitteh", "kitteh2", "ugly-kitteh"]
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        
        self.view = View(frame: UIScreen.mainScreen().bounds)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        /*let tap = UITapGestureRecognizer(target: self, action: "tapped")
        tap.numberOfTapsRequired = 2
        self.view.addGestureRecognizer( tap );*/
        
        self.currentFileNameIndex = 0;
        
        
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "tapped", userInfo: nil, repeats: true)
        self.tapped()
    }
    
    func tapped(){
        
        if (currentFileNameIndex != self.fileNames.count - 1) {
            self.currentFileNameIndex++
        } else {
            self.currentFileNameIndex = 0
        }
        
    }

}

