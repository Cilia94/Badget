//
//  SnoetViewController.swift
//  FindTheSnoetje
//
//  Created by Frederik Jacques on 05/05/15.
//  Copyright (c) 2015 devine. All rights reserved.
//

import UIKit

class TrakteerOverviewVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: - IBOutlets
    
    // MARK: - Properties
    var theView:SnoetView {
        get {
            
            return view as! SnoetView
            
        }
    }
    
    var featureContainer:UIView!
    var imageView:UIImageView!
    
    override func loadView() {
        
        view = SnoetView(frame: UIScreen.mainScreen().bounds)
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.createButton("Camera", x: 160, y: 375, w: 75, h: 40, center: true, function: "cameraButtonTouched")
        
    }
    
    func cameraButtonTouched(){
        
        // NAVIGATIONController DEBUG
        var checkVC = TrakteerCheckVC()
        self.presentViewController(checkVC, animated: true, completion: nil)
        checkVC.cameraButtonTouched()
        
    }
    
    func createButton(btnTitle:String, x:Int, y:Int, w:Int, h:Int, center:Bool, function:String){
        
        let button = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        button.setTitle(btnTitle, forState: UIControlState.Normal)
        button.frame = CGRect(x: x, y: y, width: w, height: h)
        if (center == true){
            button.center = CGPoint(x: x, y: y )
        }
        self.view.addSubview(button)
        
        button.addTarget(self, action: Selector(function), forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
}
