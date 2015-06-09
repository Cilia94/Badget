//
//  SnoetViewController.swift
//  FindTheSnoetje
//
//  Created by Frederik Jacques on 05/05/15.
//  Copyright (c) 2015 devine. All rights reserved.
//

import UIKit

class SnoetViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: - IBOutlets
    
    // MARK: - Properties
    var theView:SnoetView {
        get {
            
            return view as! SnoetView
            
        }
    }
    
    var featureContainer:UIView!
    var imageView:UIImageView!
    var ratio:Float!
    var imageInPortrait:Bool!
    
    // MARK: - Initializers methods
    
    // MARK: - Lifecycle methods
    override func loadView() {
        
        view = SnoetView(frame: UIScreen.mainScreen().bounds)
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Camera, target: self, action: "cameraButtonTouched");
        
    }
    
    func cameraButtonTouched(){
        
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
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
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
        
        
        let detectFacesButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        detectFacesButton.setTitle("Detect snoetjes", forState: UIControlState.Normal)
        detectFacesButton.frame = CGRect(x: 0, y: 0, width: 960, height: 1280.0)
        detectFacesButton.center = CGPoint(x: 320/2, y: 400 )
        self.view.addSubview(detectFacesButton)
        
        detectFacesButton.addTarget(self, action: "detectSnoetjesButtonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        
        //NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "tickHandler", userInfo: nil, repeats: false)
    }
    
    func tickHandler(){
        
        self.imageView.image = nil;
        
    }
    
    func detectSnoetjesButtonClicked( sender:UIButton ) {
        
        println("[SnoetVC] Detect button clicked")
        
        let context = CIContext(options: nil)
        
        let detector = CIDetector(ofType: CIDetectorTypeFace, context: context, options: [CIDetectorAccuracy:CIDetectorAccuracyHigh])
        
        let image = CIImage(image: self.imageView.image)
        
        println(self.imageView.image!.size.width)
        println(self.imageView.image!.size.height)
        
        
        if (self.imageInPortrait == true) {
            if (self.imageView.image!.size.width == 960){
                println("Front Camera PORTRAIT")
                let features = detector.featuresInImage(image, options: [CIDetectorImageOrientation:5])
            
                for feature in features {
                
                    var featureBounds = feature.bounds
                
                    var startY = self.imageView.bounds.origin.y
                
                    featureBounds.origin.x = startY + (feature.bounds.origin.y / CGFloat(self.ratio))
                    featureBounds.origin.y = (feature.bounds.origin.x / CGFloat(self.ratio))
                    featureBounds.size.width = feature.bounds.size.width / CGFloat(self.ratio)
                
                    featureBounds.size.height = feature.bounds.size.height / CGFloat(self.ratio)
                    
                    self.drawFaceRecognitionBox(featureBounds)
                }
            } else {
                println("Back Camera PORTRAIT")
                let features = detector.featuresInImage(image, options: [CIDetectorImageOrientation:5])
                println(features.count)
            
                for feature in features {
                
                    var featureBounds = feature.bounds
                
                    var startY = self.imageView.bounds.size.height
                
                    featureBounds.origin.x = (feature.bounds.origin.y / CGFloat(self.ratio))
                    featureBounds.origin.y = (feature.bounds.origin.x / CGFloat(self.ratio))
                    featureBounds.size.width = feature.bounds.size.width / CGFloat(self.ratio)
                
                    featureBounds.size.height = feature.bounds.size.height / CGFloat(self.ratio)
                    
                    self.drawFaceRecognitionBox(featureBounds)
                }
            
            }
        } else {
            if (self.imageView.image!.size.width == 1280){
                println("Front Camera LANDSCAPE")
                let features = detector.featuresInImage(image, options: [CIDetectorImageOrientation:4])
                
                for feature in features {
                    
                    var featureBounds = feature.bounds
                    
                    var heightImageView = self.imageView.bounds.size.height
                    var startY = self.imageView.bounds.origin.y
                    
                    featureBounds.origin.x = 320 - (feature.bounds.origin.x / CGFloat(self.ratio)) - (feature.bounds.size.width / CGFloat(self.ratio))
                    featureBounds.origin.y = startY + (feature.bounds.origin.y / CGFloat(self.ratio))
                    featureBounds.size.width = feature.bounds.size.width / CGFloat(self.ratio)
                    
                    featureBounds.size.height = feature.bounds.size.height / CGFloat(self.ratio)
                    
                    self.drawFaceRecognitionBox(featureBounds)
                }
            } else {
                var features = detector.featuresInImage(image, options: [CIDetectorImageOrientation:1])
                println("Back Camera LANDSCAPE : \(features.count) features")
                
                for feature in features {
                    
                    var featureBounds = feature.bounds
                    
                    var startY = self.imageView.bounds.size.height
                    
                    featureBounds.origin.x = feature.bounds.origin.x / CGFloat(self.ratio)
                    featureBounds.origin.y = startY - ( feature.bounds.size.height / CGFloat(self.ratio) ) - (feature.bounds.origin.y / CGFloat(self.ratio))
                    featureBounds.size.width = feature.bounds.size.width / CGFloat(self.ratio)
                    
                    featureBounds.size.height = feature.bounds.size.height / CGFloat(self.ratio)
                    
                    self.drawFaceRecognitionBox(featureBounds)
                }
                
            }
        }
    }
    
    func drawFaceRecognitionBox(featureBounds:CGRect) {
        
        var extra = Float(featureBounds.size.width) / 3
        
        let view = UIView(frame: CGRectMake(CGFloat(Float(featureBounds.origin.x) - extra/2), CGFloat(Float(featureBounds.origin.y) - extra/2), CGFloat(Float(featureBounds.size.width) + extra), CGFloat(Float(featureBounds.size.height) + extra)))
        
        view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        view.layer.borderWidth = CGFloat(Float(featureBounds.size.width) / 20)
        view.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1).CGColor
        
        self.imageView.addSubview(view)
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
}
