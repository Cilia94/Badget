//
//  Makkers Maker
//  Major 4 - Devine Howest
//
//  Eliot Colinet & Cilia Vandenameele
//  Copyright (c) 2015. All rights reserved.

import UIKit

class TrakteerCheckVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var featureContainer:UIView!
    var imageView:UIImageView!
    var ratio:Float!
    var imageInPortrait:Bool!
    var vraag:UILabel!
    var featuresList:[CGRect] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //self.view.backgroundColor = UIColor.orangeColor()
        
       
        
        
        
        
        
    }
    
    override init(nibName nibNameOrNil:String?, bundle nibBundleOrNil:NSBundle?){
        
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.view = TrakteerCheckView(frame: UIScreen.mainScreen().bounds)
        
        self.vraag = UILabel(frame: CGRectMake(160, 375, 300, 50))
        self.vraag.center = CGPoint(x: 160, y: 375)
        self.vraag.numberOfLines = 0
        self.vraag.textColor =  UIColor(red: 233/225, green: 122/225, blue: 130/225, alpha: 1)
        //self.vraag.font = UIFont(name: "AvenirNextCondensed-DemiBoldItalic", size: 30)
        self.view.addSubview(self.vraag)
        
        self.createButton("Nee", x: 20, y: 420, w: 125, h: 50, center: false, function: "cameraButtonTouched")
        
        self.createButton("Ja", x: 170, y: 420, w: 125, h: 50, center: false, function: "toRandomVC")
        
        
        //var button = pageButton(theViewC: self, titel: "Camera", targetfunction: "next")
        
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            
            println("Camera niet beschikbaar")
            self.noCameraAlert()
        }
        
    }
    
    func noCameraAlert() {
        let alert = UIAlertController(
            title: "GEEN CAMERA",
            message: "Camera is niet beschikbaar",
            preferredStyle: UIAlertControllerStyle.Alert
        )
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action) -> Void in
            // Code
        }
        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
        self.setImage(image)
        
    }
    
    func setImage(image:UIImage) {
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
        
        self.detectFaces()
    }
    
    func toRandomVC(){
        
        UIImageWriteToSavedPhotosAlbum(self.imageView.image!, self, "image:didFinishSavingWithError:contextInfo:", nil)
        
        var randomVC = TrakteerRandomVC()
        navigationController?.pushViewController(randomVC, animated: true)
        
        randomVC.setImage(self.imageView.image!, features: self.featuresList)
        
    }
    
    func createButton(btnTitle:String, x:Int, y:Int, w:Int, h:Int, center:Bool, function:String){
        
        let button = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        button.setTitle(btnTitle, forState: UIControlState.Normal)
        button.frame = CGRect(x: x, y: y, width: w, height: h)
        
        if(btnTitle == "Ja"){
            button.backgroundColor = UIColor(red: 134/225, green: 168/225, blue: 209/225, alpha: 1)
        }else{
            button.backgroundColor = UIColor(red: 233/225, green: 122/225, blue: 130/225, alpha: 1)
        }
        
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        
        if (center == true){
            button.center = CGPoint(x: x, y: y )
        }
        self.view.addSubview(button)
        
        button.addTarget(self, action: Selector(function), forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    func detectFaces() {
        
        let context = CIContext(options: nil)
        
        let detector = CIDetector(ofType: CIDetectorTypeFace, context: context, options: [CIDetectorAccuracy:CIDetectorAccuracyHigh])
        
        let image = CIImage(image: self.imageView.image)
        
        println(self.imageView.image!.size.width)
        println(self.imageView.image!.size.height)
        
        self.featuresList = []
        
        if (self.imageInPortrait == true) {
            if (self.imageView.image!.size.width == 960){
                println("Front Camera PORTRAIT")
                let features = detector.featuresInImage(image, options: [CIDetectorImageOrientation:5])
                self.vraag.text = "Er zijn \(features.count) personen gedetecteerd op deze foto. Is iedereen gedetecteerd?"
                
                for feature in features {
                
                    var featureBounds = feature.bounds
                
                    var startY = self.imageView.bounds.origin.y
                
                    featureBounds.origin.x = startY + (feature.bounds.origin.y / CGFloat(self.ratio))
                    featureBounds.origin.y = (feature.bounds.origin.x / CGFloat(self.ratio))
                    featureBounds.size.width = feature.bounds.size.width / CGFloat(self.ratio)
                
                    featureBounds.size.height = feature.bounds.size.height / CGFloat(self.ratio)
                    
                    self.drawFaceRecognitionBox(featureBounds)
                    self.featuresList.append(featureBounds)
                }
            } else {
                println("Back Camera PORTRAIT")
                let features = detector.featuresInImage(image, options: [CIDetectorImageOrientation:5])
                self.vraag.text = "Er zijn \(features.count) personen gedetecteerd op deze foto. Is iedereen gedetecteerd?"
            
                for feature in features {
                    
                    var featureBounds = feature.bounds
                
                    var startY = self.imageView.bounds.size.height
                
                    featureBounds.origin.x = (feature.bounds.origin.y / CGFloat(self.ratio))
                    featureBounds.origin.y = (feature.bounds.origin.x / CGFloat(self.ratio))
                    featureBounds.size.width = feature.bounds.size.width / CGFloat(self.ratio)
                
                    featureBounds.size.height = feature.bounds.size.height / CGFloat(self.ratio)
                    
                    self.drawFaceRecognitionBox(featureBounds)
                    self.featuresList.append(featureBounds)
                }
            
            }
        } else {
            if (self.imageView.image!.size.width == 1280){
                println("Front Camera LANDSCAPE")
                let features = detector.featuresInImage(image, options: [CIDetectorImageOrientation:4])
                self.vraag.text = "Er zijn \(features.count) personen gedetecteerd op deze foto. Is iedereen gedetecteerd?"
                
                for feature in features {
                    
                    var featureBounds = feature.bounds
                    
                    var heightImageView = self.imageView.bounds.size.height
                    var startY = self.imageView.bounds.origin.y
                    
                    featureBounds.origin.x = 320 - (feature.bounds.origin.x / CGFloat(self.ratio)) - (feature.bounds.size.width / CGFloat(self.ratio))
                    featureBounds.origin.y = startY + (feature.bounds.origin.y / CGFloat(self.ratio))
                    featureBounds.size.width = feature.bounds.size.width / CGFloat(self.ratio)
                    
                    featureBounds.size.height = feature.bounds.size.height / CGFloat(self.ratio)
                    
                    self.drawFaceRecognitionBox(featureBounds)
                    self.featuresList.append(featureBounds)
                }
            } else {
                var features = detector.featuresInImage(image, options: [CIDetectorImageOrientation:1])
                self.vraag.text = "Er zijn \(features.count) personen gedetecteerd op deze foto. Is iedereen gedetecteerd?"
                println("Back Camera LANDSCAPE : \(features.count) features")
                
                for feature in features {
                    
                    var featureBounds = feature.bounds
                    
                    var startY = self.imageView.bounds.size.height
                    
                    featureBounds.origin.x = feature.bounds.origin.x / CGFloat(self.ratio)
                    featureBounds.origin.y = startY - ( feature.bounds.size.height / CGFloat(self.ratio) ) - (feature.bounds.origin.y / CGFloat(self.ratio))
                    featureBounds.size.width = feature.bounds.size.width / CGFloat(self.ratio)
                    
                    featureBounds.size.height = feature.bounds.size.height / CGFloat(self.ratio)
                    
                    self.drawFaceRecognitionBox(featureBounds)
                    self.featuresList.append(featureBounds)
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
    
    func image(image: UIImage, didFinishSavingWithError
        error: NSErrorPointer, contextInfo:UnsafePointer<Void>) {
            
            if error != nil {
                // Report error to user
            }
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
}
