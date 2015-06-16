//
//  Makkers Maker
//  Major 4 - Devine Howest
//
//  Eliot Colinet & Cilia Vandenameele
//  Copyright (c) 2015. All rights reserved.

import UIKit

class GScheckVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var featureContainer:UIView!
    var imageView:UIImageView!
    var ratio:Float!
    var imageInPortrait:Bool!
    var vraag:UILabel!
    var featuresList:[CGRect] = []
    var groupComplete:Bool = false
    var btn:pageButton!
    
    var theView:CheckView {
        get {
            return self.view as! CheckView
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view = CheckView(frame: UIScreen.mainScreen().bounds)
        //self.view.backgroundColor = UIColor.orangeColor()
        
        
        let font = UIFont(name: "DKBlackBamboo", size: 25)
        
        
        
        self.vraag = UILabel(frame: CGRectMake(20, 360, 280, 70))
        //self.vraag.center = CGPoint(x: 245, y: 530)
        self.vraag.numberOfLines = 0
        self.vraag.textAlignment = NSTextAlignment.Center
        
        self.vraag.font = font
        self.vraag.textColor = UIColor(red: 73/225, green: 118/225, blue: 171/225, alpha: 1)
        
        
        self.view.addSubview(self.vraag)
        
        self.btn = pageButton(theViewC: self, titel: "Upload", targetfunction: "next")
        
        
        
        //self.btn = self.createButton("Upload foto", x: 160, y: 400, w: 150, h: 50, center: true, function: "buttonClicked")
        
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
    
    func setImage(image:UIImage) {
        self.ratio = Float(image.size.width) / 320
        
        self.imageView = UIImageView(frame: CGRectMake(0, 120, 320, 240))
        self.imageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        if (image.size.height > image.size.width) {
            let newImage = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(CGFloat(image.size.height / 5), 0, CGFloat(240 * self.ratio), image.size.width))
            self.imageView.image = UIImage(CGImage: newImage, scale: 1, orientation: image.imageOrientation)!
            imageInPortrait = true
        } else {
            self.imageView.image = image
            imageInPortrait = false
        }
        
        self.view.addSubview(self.imageView)
        
        self.detectFaces()
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
        self.setImage(image)
        
    }
    
    func createButton(btnTitle:String, x:Int, y:Int, w:Int, h:Int, center:Bool, function:String) -> UIButton {
        
        let button = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        button.setTitle(btnTitle, forState: UIControlState.Normal)
        button.frame = CGRect(x: x, y: y, width: w, height: h)
        if (center == true){
            button.center = CGPoint(x: x, y: y )
        }
        self.view.addSubview(button)
        
        button.addTarget(self, action: Selector(function), forControlEvents: UIControlEvents.TouchUpInside)
        
        return button
    }
    
    func detectFaces() {
        
        println("[SnoetVC] Detect button clicked")
        
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
                if (features.count >= 4) {
                    self.btn.button!.setTitle("Upload foto", forState: UIControlState.Normal)
                    self.vraag.text = "Mooie foto!"
                    groupComplete = true
                    self.theView.genoegMensen = true;
                } else {
                    self.btn.button!.setTitle("Nieuwe foto", forState: UIControlState.Normal)
                    self.vraag.text = "Er werden geen 4 personen gedetecteerd op deze foto."
                    groupComplete = false
                   self.theView.uitlegCh = "Oei";
                }
            } else {
                println("Back Camera PORTRAIT")
                let features = detector.featuresInImage(image, options: [CIDetectorImageOrientation:5])
                if (features.count >= 4) {
                    self.btn.button!.setTitle("Upload foto", forState: UIControlState.Normal)
                    self.vraag.text = "Mooie foto!"
                    groupComplete = true
                    self.theView.genoegMensen = true;
                } else {
                    self.btn.button!.setTitle("Nieuwe foto", forState: UIControlState.Normal)
                    self.vraag.text = "Er werden geen 4 personen gedetecteerd op deze foto."
                    groupComplete = false
                    self.theView.uitlegCh = "Oei";
                }
            
            }
        } else {
            if (self.imageView.image!.size.width == 1280){
                println("Front Camera LANDSCAPE")
                let features = detector.featuresInImage(image, options: [CIDetectorImageOrientation:4])
                if (features.count >= 4) {
                    self.btn.button!.setTitle("Upload foto", forState: UIControlState.Normal)
                    self.vraag.text = "Mooie foto!"
                    groupComplete = true
                    self.theView.genoegMensen = true;
                } else {
                    self.btn.button!.setTitle("Nieuwe foto", forState: UIControlState.Normal)
                    self.vraag.text = "Er werden geen 4 personen gedetecteerd op deze foto."
                    groupComplete = false
                     self.theView.uitlegCh = "Oei";
                }
            } else {
                var features = detector.featuresInImage(image, options: [CIDetectorImageOrientation:1])
                if (features.count >= 4) {
                    self.btn.button!.setTitle("Upload foto", forState: UIControlState.Normal)
                    self.vraag.text = "Mooie foto!"
                    groupComplete = true
                    self.theView.genoegMensen = true;
                } else {
                    self.btn.button!.setTitle("Nieuwe foto", forState: UIControlState.Normal)
                    self.vraag.text = "Er werden geen 4 personen gedetecteerd op deze foto."
                    groupComplete = false
                    self.theView.uitlegCh = "Oei";
                }
                
            }
        }
    }
    
    func nextPage(sender:UIButton!) {
        if (groupComplete == true) {
            self.uploadImage()
            UIImageWriteToSavedPhotosAlbum(self.imageView.image!, self, "image:didFinishSavingWithError:contextInfo:", nil)
        } else {
            self.camera()
        }
    }
    
    func uploadImage() {
        println("upload")
        var image:UIImage = self.RBResizeImage(self.imageView.image!, targetSize: CGSizeMake(640, 480))
        let imageData:NSData = NSData(data: UIImageJPEGRepresentation(image, 1.0))
        SRWebClient.POST("http://student.howest.be/eliot.colinet/20142015/MA4/BADGET/api/images")
            .data(imageData, fieldName:"file", data:["id":"","user_id":"2","image":"swift.jpg"])
            .send({(response:AnyObject!, status:Int) -> Void in
                //process success response
                println(response)
                },failure:{(error:NSError!) -> Void in
                    //process failure response
                    println(error)
            })
        
        var badgeVC = Badge3VC()
        navigationController?.pushViewController(badgeVC, animated: true)
    }
    
    func image(image: UIImage, didFinishSavingWithError
        error: NSErrorPointer, contextInfo:UnsafePointer<Void>) {
            
            if error != nil {
                // Report error to user
            }
    }
    
    func RBResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
        } else {
            newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
}
