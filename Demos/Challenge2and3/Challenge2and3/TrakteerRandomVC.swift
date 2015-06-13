//
//  SnoetViewController.swift
//  FindTheSnoetje
//
//  Created by Frederik Jacques on 05/05/15.
//  Copyright (c) 2015 devine. All rights reserved.
//

import UIKit

class TrakteerRandomVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var featureContainer:UIView!
    var imageView:UIImageView!
    var ratio:Float!
    var imageInPortrait:Bool!
    var facebox:UIView!
    var features:[CGRect] = []
    var kroontje:UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.greenColor()
        
        self.createButton("random", x: 160, y: 375, w: 75, h: 40, center: true, function: "randomizeButtonClicked")
        
        self.createButton("nieuwe foto", x: 160, y: 425, w: 150, h: 40, center: true, function: "camera")
        
    }
    
    func camera(){
        
        println("Camera button touched");
        
        if ( UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) ){
            
            println("Camera beschikbaar");
            var mediatypes = UIImagePickerController.availableMediaTypesForSourceType(UIImagePickerControllerSourceType.Camera)
            println(mediatypes) // public.image, public.movie
            
            let imagepicker = UIImagePickerController()
            imagepicker.delegate = self;
            imagepicker.mediaTypes = mediatypes!
            imagepicker.sourceType = UIImagePickerControllerSourceType.Camera
            
            self.presentViewController(imagepicker, animated: true, completion: nil)
            
        }else{
            println("Camera niet beschikbaar");
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        var checkVC = TrakteerCheckVC()
        navigationController?.pushViewController(checkVC, animated: true)
        
        checkVC.setImage(image)
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func setImage(image:UIImage, features:[CGRect]) {
        self.ratio = Float(image.size.width) / 320
        
        self.imageView = UIImageView(frame: CGRectMake(0, 100, 320, 240))
        self.imageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        if (image.size.height > image.size.width) {
            let newImage = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(CGFloat(image.size.height / 5), 0, CGFloat(240 * self.ratio), image.size.width))
            //self.imageView.image = UIImage(CGImage: newImage, scale: UIScreen.mainScreen().scale, orientation: image.imageOrientation)!
            self.imageView.image = UIImage(CGImage: newImage, scale: 1, orientation: image.imageOrientation)!
            imageInPortrait = true
        } else {
            self.imageView.image = image
            imageInPortrait = false
        }
        
        self.view.addSubview(self.imageView)
        
        self.facebox = UIView(frame: CGRectNull)
        self.kroontje = UIImageView(frame: CGRectNull)
        
        self.features = features
        
    }
    
    func randomizeButtonClicked(){
        var list = [0, 0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35, 0.4, 0.45, 0.5, 0.6, 0.7, 0.8, 0.9, 1, 1.2, 1.4, 1.6, 1.8, 2, 2.3, 2.6, 3, 3.3, 3.6, 3.9, 4.5, 5]
        
        for index in 0...(list.count - 1) {
            NSTimer.scheduledTimerWithTimeInterval(list[index], target: self, selector: "randomize", userInfo: nil, repeats: false)
        }
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
    
    func randomize(){
        
        var randomNmbr = Int(arc4random_uniform(UInt32(self.features.count)))
        
        //self.drawFaceRecognitionBox(self.features[randomNmbr])
        self.drawKroontje(self.features[randomNmbr])
        
    }
    
    func drawFaceRecognitionBox(featureBounds:CGRect) {
        self.facebox.removeFromSuperview()
        self.facebox = UIView(frame: featureBounds)
        
        var extra = Float(featureBounds.size.width) / 3
        self.facebox.frame = CGRectMake(CGFloat(Float(featureBounds.origin.x) - extra/2), CGFloat(Float(featureBounds.origin.y) - extra/2), CGFloat(Float(featureBounds.size.width) + extra), CGFloat(Float(featureBounds.size.height) + extra))
        self.facebox.layer.borderWidth = CGFloat(Float(featureBounds.size.width) / 20)
        self.facebox.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.facebox.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1).CGColor
        
        self.imageView.addSubview(self.facebox)
    }
    
    func drawKroontje(featureBounds:CGRect) {
        self.kroontje.removeFromSuperview()
        self.kroontje = UIImageView(image: UIImage(named: "kroontje"))
        
        var extra = Float(featureBounds.size.width) / 3
        self.kroontje.frame = CGRectMake(CGFloat(Float(featureBounds.origin.x) - extra/2), CGFloat(Float(featureBounds.origin.y) - 2 * extra), CGFloat(Float(featureBounds.size.width) + extra), CGFloat(Float(featureBounds.size.height)))
        //self.kroontje.layer.borderWidth = CGFloat(Float(featureBounds.size.width) / 20)
        //self.kroontje.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        //self.kroontje.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1).CGColor
        
        self.imageView.addSubview(self.kroontje)
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
}
