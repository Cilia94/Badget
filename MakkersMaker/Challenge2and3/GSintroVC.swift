//
//  Makkers Maker
//  Major 4 - Devine Howest
//
//  Eliot Colinet & Cilia Vandenameele
//  Copyright (c) 2015. All rights reserved.

import UIKit

class GSintroVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    var featureContainer:UIView!
    var imageView:UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //self.createButton("Camera", x: 160, y: 375, w: 75, h: 40, center: true, function: "camera")
        
    }
    
    override init(nibName nibNameOrNil:String?, bundle nibBundleOrNil:NSBundle?){
        
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.view = ConceptView(concept:"concept3", titel:"Fotoronde", subtitel:"Selfie time!", uitlegCh: "Ga samen met het andere team de strijd aan in de ultieme Bierbattle!")
        //self.view = BadgeView(badge: 1, titel: "Speurneus", uitleg: "jajaja", image: "badge1")
        var button = pageButton(theViewC: self, titel: "Camera", targetfunction: "next")
        
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func nextPage(sender:UIButton!){
        
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
        
        var checkVC = GScheckVC()
        navigationController?.pushViewController(checkVC, animated: true)
        
        checkVC.setImage(image)
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
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
