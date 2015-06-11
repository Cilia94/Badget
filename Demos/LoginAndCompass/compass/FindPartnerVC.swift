//
//  ViewController.swift
//  Alamo
//
//  Created by Eliot Colinet on 28/05/15.
//  Copyright (c) 2015 Eliot Colinet. All rights reserved.
//

import UIKit
import Alamofire

class FindPartnerVC: UIViewController {
    
    var nameInput:UITextField!
    let stageBtn:UIButton!
    let genreBtn:UIButton!
    var fav_stage:String!
    var fav_genre:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        NSUserDefaults.standardUserDefaults().setInteger(1, forKey: "lastPage")
        
        //self.clearNSUserDefault()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.login()
        
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    func login(){
        println("LOGIN")
        
        let nameLabel = UILabel(frame: CGRectMake(50, 75, 500, 50))
        nameInput = UITextField(frame: CGRectMake(50, 100, 500, 50))
        
        nameLabel.text = "Name :"
        nameInput.placeholder = "Name"
        
        self.view.addSubview(nameLabel)
        self.view.addSubview(nameInput)
        
        let stageLabel = UILabel(frame: CGRectMake(50, 150, 500, 50))
        stageLabel.text = "Favourite stage :"
        self.view.addSubview(stageLabel)
        
        stageBtn.setTitle("Select stage...", forState: UIControlState.Normal)
        stageBtn.frame = CGRect(x: 50, y: 175, width: 250, height: 50)
        self.view.addSubview(stageBtn)
        stageBtn.addTarget(self, action: "stageButtonTouched", forControlEvents: UIControlEvents.TouchUpInside)
        
        let genreLabel = UILabel(frame: CGRectMake(50, 225, 500, 50))
        genreLabel.text = "Favourite genre :"
        self.view.addSubview(genreLabel)
        
        genreBtn.setTitle("Select genre...", forState: UIControlState.Normal)
        genreBtn.frame = CGRect(x: 50, y: 250, width: 250, height: 50)
        self.view.addSubview(genreBtn)
        genreBtn.addTarget(self, action: "genreButtonTouched", forControlEvents: UIControlEvents.TouchUpInside)
        
        let sendBtn = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        sendBtn.setTitle("Send...", forState: UIControlState.Normal)
        sendBtn.frame = CGRect(x: 50, y: 350, width: 250, height: 50)
        self.view.addSubview(sendBtn)
        sendBtn.addTarget(self, action: "sendClicked:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func DismissKeyboard(){
        view.endEditing(true)
    }
    
    func clearNSUserDefault(){
        let appDomain = NSBundle.mainBundle().bundleIdentifier!
        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain)
        if (NSUserDefaults.standardUserDefaults().integerForKey("user_id") == 0 && NSUserDefaults.standardUserDefaults().integerForKey("partner_id") == 0 && NSUserDefaults.standardUserDefaults().integerForKey("loc_id") == 0) {
            println("[DEBUG] NSUserDefault cleared!")
        }
    }
    
    func sendClicked( sender:UIButton ) {
        var error = 0
        //Validation
        if (nameInput.text == "") {
            validationAlert("Login mislukt", message: "Gelieve uw naam in te vullen")
            return
        }
        if (self.fav_stage == "") {
            validationAlert("Login mislukt", message: "Gelieve uw favoriete podium te selecteren")
            return
        }
        if (self.fav_genre == "") {
            validationAlert("Login mislukt", message: "Gelieve uw favoriete genre te selecteren")
            return
        }
        
        if (NSUserDefaults.standardUserDefaults().integerForKey("user_id") != 0) {
            return
        }
        
        /* DEBUG
        for view in self.view.subviews{
            view.removeFromSuperview()
        }*/
        
        
        println(nameInput.text)
        println(self.fav_stage)
        println(self.fav_genre)
        
        self.postNewUser(nameInput.text)
        
    }
    
    func postNewUser(name:String){
        
        let parameters = [
            "id": "",
            "name": name,
            "partner_id": "",
            "partner_found": 0,
            "fav_stage": self.fav_stage,
            "fav_genre": self.fav_genre
        ]
        
        Alamofire.request(.POST, "http://student.howest.be/eliot.colinet/20142015/MA4/BADGET/api/users", parameters: parameters as? [String : AnyObject]).responseJSON{(_,_,data,_) in
            var json = JSON(data!)
            
            NSUserDefaults.standardUserDefaults().setInteger(json["id"].intValue, forKey: "user_id")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            self.findPartner()
        }
    }
    
    func findPartner(){
        
        Alamofire.request(.GET, "http://student.howest.be/eliot.colinet/20142015/MA4/BADGET/api/users").responseJSON{(_,_,data,_) in
            var json = JSON(data!)
            
            var partner_id = 0
            
            for Dict in json.arrayValue {
                if ( self.fav_stage == Dict["fav_stage"].stringValue && self.fav_genre == Dict["fav_genre"].stringValue && Dict["partner_id"].intValue == 0 && Dict["id"].intValue != NSUserDefaults.standardUserDefaults().integerForKey("user_id")) {
                    
                    NSUserDefaults.standardUserDefaults().setInteger(Dict["id"].intValue, forKey: "partner_id")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    partner_id = Dict["id"].intValue
                    println("Partner_id : \(partner_id)")
                }
            }
            
            if (partner_id == 0){
                println("geen partner gevonden...")
                let noPartner = NoPartnerVC();
                self.navigationController?.pushViewController(noPartner, animated: true)
            } else {
                self.createUserLocation()
                self.setPartners(NSUserDefaults.standardUserDefaults().integerForKey("user_id"), id2: NSUserDefaults.standardUserDefaults().integerForKey("partner_id"))
            }
        }
    }
    
    func createUserLocation(){
        
        let parameters = [
            "id": "",
            "user_id": NSUserDefaults.standardUserDefaults().integerForKey("user_id"),
            "latitude": "",
            "longitude": ""
        ]
        
        Alamofire.request(.POST, "http://student.howest.be/eliot.colinet/20142015/MA4/BADGET/api/locations", parameters: parameters as? [String : AnyObject]).responseJSON{(_,_,data,_) in
            var json = JSON(data!)
            
            NSUserDefaults.standardUserDefaults().setInteger(json["id"].intValue, forKey: "loc_id")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    func setPartners(id1:Int, id2:Int){
        
        Alamofire.request(.GET, "http://student.howest.be/eliot.colinet/20142015/MA4/BADGET/api/users/\(id1)").responseJSON{(_,_,data,_) in
            var json = JSON(data!)
            
            println(json)
                
            let parameters = [
                "id": json["id"].intValue,
                "name": json["name"].stringValue,
                "partner_id": id2,
                "partner_found": 0,
                "fav_stage": json["fav_stage"].stringValue,
                "fav_genre": json["fav_genre"].stringValue
            ]
            Alamofire.request(.PUT, "http://student.howest.be/eliot.colinet/20142015/MA4/BADGET/api/users/\(id1)", parameters: parameters as? [String : AnyObject])
            
        }
        
        Alamofire.request(.GET, "http://student.howest.be/eliot.colinet/20142015/MA4/BADGET/api/users/\(id2)").responseJSON{(_,_,data,_) in
            var json = JSON(data!)
            
            let parameters = [
                "id": json["id"].intValue,
                "name": json["name"].stringValue,
                "partner_id": id1,
                "partner_found": 0,
                "fav_stage": json["fav_stage"].stringValue,
                "fav_genre": json["fav_genre"].stringValue
            ]
            Alamofire.request(.PUT, "http://student.howest.be/eliot.colinet/20142015/MA4/BADGET/api/users/\(id2)", parameters: parameters as? [String : AnyObject])
            
        }
        
        let compass = CompassVC();
        self.navigationController?.pushViewController(compass, animated: true)
    }
    
    func stageButtonTouched(){
        
        let alert = UIAlertController(
            title: "Favoriete podium",
            message: "Gelieve uw favoriete podium te selecteren",
            preferredStyle: UIAlertControllerStyle.ActionSheet
        )
        
        let mainStageAction = UIAlertAction(title: "Main Stage", style: UIAlertActionStyle.Default) { (action) -> Void in
            self.stageBtn.setTitle("Main Stage", forState: UIControlState.Normal)
            self.fav_stage = "Main Stage"
        }
        let marqueeAction = UIAlertAction(title: "Marquee", style: UIAlertActionStyle.Default) { (action) -> Void in
            self.stageBtn.setTitle("Marquee", forState: UIControlState.Normal)
            self.fav_stage = "Marquee"
        }
        let danceHallAction = UIAlertAction(title: "Dance Hall", style: UIAlertActionStyle.Default) { (action) -> Void in
            self.stageBtn.setTitle("Dance Hall", forState: UIControlState.Normal)
            self.fav_stage = "Dance Hall"
        }
        let theShelterAction = UIAlertAction(title: "The Shelter", style: UIAlertActionStyle.Default) { (action) -> Void in
            self.stageBtn.setTitle("The Shelter", forState: UIControlState.Normal)
            self.fav_stage = "The Shelter"
        }
        let boilerRoomAction = UIAlertAction(title: "Boiler Room", style: UIAlertActionStyle.Default) { (action) -> Void in
            self.stageBtn.setTitle("Boiler Room", forState: UIControlState.Normal)
            self.fav_stage = "Boiler Room"
        }
        let castelloAction = UIAlertAction(title: "Castello", style: UIAlertActionStyle.Default) { (action) -> Void in
            self.stageBtn.setTitle("Castello", forState: UIControlState.Normal)
            self.fav_stage = "Castello"
        }
        let clubAction = UIAlertAction(title: "Club", style: UIAlertActionStyle.Default) { (action) -> Void in
            self.stageBtn.setTitle("Club", forState: UIControlState.Normal)
            self.fav_stage = "Club"
        }
        let wabliefAction = UIAlertAction(title: "Wablief?!", style: UIAlertActionStyle.Default) { (action) -> Void in
            self.stageBtn.setTitle("Wablief?!", forState: UIControlState.Normal)
            self.fav_stage = "Wablief?!"
        }
        let cancelAction = UIAlertAction(title: "Annuleer", style: UIAlertActionStyle.Cancel) { (action) -> Void in
            //code
        }
        
        alert.addAction(cancelAction)
        alert.addAction(mainStageAction)
        alert.addAction(marqueeAction)
        alert.addAction(danceHallAction)
        alert.addAction(theShelterAction)
        alert.addAction(boilerRoomAction)
        alert.addAction(castelloAction)
        alert.addAction(clubAction)
        alert.addAction(wabliefAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func genreButtonTouched(){
        
        let alert = UIAlertController(
            title: "Favoriete genre",
            message: "Gelieve uw favoriete genre te selecteren",
            preferredStyle: UIAlertControllerStyle.ActionSheet
        )
        
        let popAction = UIAlertAction(title: "Pop", style: UIAlertActionStyle.Default) { (action) -> Void in
            self.genreBtn.setTitle("Pop", forState: UIControlState.Normal)
            self.fav_genre = "Pop"
        }
        let rockAction = UIAlertAction(title: "Rock", style: UIAlertActionStyle.Default) { (action) -> Void in
            self.genreBtn.setTitle("Rock", forState: UIControlState.Normal)
            self.fav_genre = "Rock"
        }
        let indieAction = UIAlertAction(title: "Indie", style: UIAlertActionStyle.Default) { (action) -> Void in
            self.genreBtn.setTitle("Indie", forState: UIControlState.Normal)
            self.fav_genre = "Indie"
        }
        let electroAction = UIAlertAction(title: "Electro", style: UIAlertActionStyle.Default) { (action) -> Void in
            self.genreBtn.setTitle("Electro", forState: UIControlState.Normal)
            self.fav_genre = "Electro"
        }
        let technoAction = UIAlertAction(title: "Techno", style: UIAlertActionStyle.Default) { (action) -> Void in
            self.genreBtn.setTitle("Techno", forState: UIControlState.Normal)
            self.fav_genre = "Techno"
        }
        let houseAction = UIAlertAction(title: "House", style: UIAlertActionStyle.Default) { (action) -> Void in
            self.genreBtn.setTitle("House", forState: UIControlState.Normal)
            self.fav_genre = "House"
        }
        let metalAction = UIAlertAction(title: "Metal", style: UIAlertActionStyle.Default) { (action) -> Void in
            self.genreBtn.setTitle("Metal", forState: UIControlState.Normal)
            self.fav_genre = "Metal"
        }
        let andereAction = UIAlertAction(title: "Andere...", style: UIAlertActionStyle.Default) { (action) -> Void in
            self.genreBtn.setTitle("Andere...", forState: UIControlState.Normal)
            self.fav_genre = "Andere"
        }
        let cancelAction = UIAlertAction(title: "Annuleer", style: UIAlertActionStyle.Cancel) { (action) -> Void in
            //code
        }
        
        alert.addAction(cancelAction)
        alert.addAction(popAction)
        alert.addAction(rockAction)
        alert.addAction(indieAction)
        alert.addAction(electroAction)
        alert.addAction(technoAction)
        alert.addAction(houseAction)
        alert.addAction(metalAction)
        alert.addAction(andereAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func validationAlert(title:String, message:String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertControllerStyle.Alert
        )
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action) -> Void in
            // Code
        }
        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override init(nibName nibNameOrNil:String?, bundle nibBundleOrNil:NSBundle?){
        
        stageBtn = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        genreBtn = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        
        fav_stage = ""
        fav_genre = ""
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
       
    }
    
    func getAllUsers() {
        
        Alamofire.request(.GET, "http://student.howest.be/eliot.colinet/20142015/MA4/BADGET/api/users")
    }
    
    func getUser(id:Int){
        
        Alamofire.request(.GET, "http://student.howest.be/eliot.colinet/20142015/MA4/BADGET/api/users/\(id)").responseJSON{(_,_,data,_) in
            var json = JSON(data!)
            
            var id = json["id"].intValue
            var name = json["name"].stringValue
            var partner_id = json["partner_id"].intValue
            var partner_found = json["partner_found"].intValue
            
        }
    }
    
    func putUser(id:Int, name:String, partner_id:Int, partner_found:Int, fav_stage:String, fav_genre:String){
        
        let parameters = [
            "id": id,
            "name": name,
            "partner_id": partner_id,
            "partner_found": partner_found,
            "fav_stage": fav_stage,
            "fav_genre": fav_genre
        ]
        
        Alamofire.request(.PUT, "http://student.howest.be/eliot.colinet/20142015/MA4/BADGET/api/users/\(id)", parameters: parameters as? [String : AnyObject])
    }
    
    func deleteUser(id:Int){
        Alamofire.request(.DELETE, "http://student.howest.be/eliot.colinet/20142015/MA4/BADGET/api/users/\(id)")
    }

}
