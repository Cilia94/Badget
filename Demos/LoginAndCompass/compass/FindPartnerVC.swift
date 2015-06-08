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
    var saved_user:[SavedUser]
    var filename: String{
        get{
            let documentsPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as! String
            return documentsPath.stringByAppendingPathComponent("users")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (saved_user.count == 0) {
            let user = SavedUser(id: 0, name: "User", partner_id: 0)
            saved_user.append(user)
            if NSKeyedArchiver.archiveRootObject(saved_user, toFile: filename){
                println("save successfull")
            }
            else{
                println("cannot save")
            }
        }
        
        if (saved_user[0].id == 0) {
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
        } else {
            if (saved_user[0].partner_id == 0) {
                let alertLabel = UILabel(frame: CGRectMake(50, 75, 500, 50))
                alertLabel.text = "!!! User logged in but needs partner !!!"
                self.view.addSubview(alertLabel)
            } else {
                let alertLabel = UILabel(frame: CGRectMake(50, 75, 500, 50))
                alertLabel.text = "!!! User already logged in with partner !!!"
                self.view.addSubview(alertLabel)
            }
        }
        
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    func DismissKeyboard(){
        
        view.endEditing(true)
    }
    
    func sendClicked( sender:UIButton ) {
        var error = 0
        //Validation
        if (nameInput.text == "") {
            //Foutmelding weergeven
            error++
        }
        if (self.fav_stage == "") {
            //Foutmelding weergeven
            error++
        }
        if (self.fav_genre == "") {
            //Foutmelding weergeven
            error++
        }
        
        if (error > 0) {
            error = 0
            return
        }
        
        if (saved_user[0].id != 0) {
            return
        }
        
        for view in self.view.subviews{
            view.removeFromSuperview()
        }
        
        println(nameInput.text)
        println(self.fav_stage)
        println(self.fav_genre)
        
        saved_user[0].name = nameInput.text
        
        self.postNewUser(nameInput.text)
    }
    
    func findPartner(){
        
        Alamofire.request(.GET, "http://student.howest.be/eliot.colinet/20142015/MA4/BADGET/api/users").responseJSON{(_,_,data,_) in
            var json = JSON(data!)
            
            for Dict in json.arrayValue {
                if ( self.fav_stage == Dict["fav_stage"].stringValue && self.fav_genre == Dict["fav_genre"].stringValue && Dict["partner_id"].intValue == 0 && Dict["id"].intValue != self.saved_user[0].id) {
                    self.saved_user[0].partner_id = Dict["id"].intValue
                    println("Partner_id : \(self.saved_user[0].partner_id)")
                }
            }
            if (self.saved_user[0].partner_id == 0){
                println("geen partner gevonden...")
            } else {
                //Put partner_id (beide)
                self.setPartners(self.saved_user[0].id, id2: self.saved_user[0].partner_id)
            }
        }
        NSKeyedArchiver.archiveRootObject(saved_user, toFile: filename)
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override init(nibName nibNameOrNil:String?, bundle nibBundleOrNil:NSBundle?){
        stageBtn = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        genreBtn = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        
        fav_stage = ""
        fav_genre = ""
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as! String
        let theFile = documentsPath.stringByAppendingPathComponent("users")
        println(documentsPath)
        if let loadedFile = NSKeyedUnarchiver.unarchiveObjectWithFile(theFile) as? [SavedUser]{
            saved_user = loadedFile
        }
        else{
            saved_user = [SavedUser]()
        }
        
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
            
            for Dict in json.arrayValue {
                
                var id = Dict["id"].intValue
                var name = Dict["name"].stringValue
                var partner_id = Dict["partner_id"].intValue
                var partner_found = Dict["partner_found"].intValue
                
            }
        }
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
            
            self.saved_user[0].id = json["id"].intValue
            println(self.saved_user[0].id)
            
            self.findPartner()
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
    
    func setPartners(id1:Int, id2:Int){
        
        Alamofire.request(.GET, "http://student.howest.be/eliot.colinet/20142015/MA4/BADGET/api/users/\(id1)").responseJSON{(_,_,data,_) in
            var json = JSON(data!)
            
            for Dict in json.arrayValue {
                
                let parameters = [
                    "id": Dict["id"].intValue,
                    "name": Dict["fav_stage"].stringValue,
                    "partner_id": id2,
                    "partner_found": 0,
                    "fav_stage": Dict["fav_stage"].stringValue,
                    "fav_genre": Dict["fav_genre"].stringValue
                ]
                Alamofire.request(.PUT, "http://student.howest.be/eliot.colinet/20142015/MA4/BADGET/api/users/\(id1)", parameters: parameters as? [String : AnyObject])
                
                let compass = CompassVC();
                self.navigationController?.pushViewController(compass, animated: true)
            }
        }
        
        Alamofire.request(.GET, "http://student.howest.be/eliot.colinet/20142015/MA4/BADGET/api/users/\(id2)").responseJSON{(_,_,data,_) in
            var json = JSON(data!)
            
            for Dict in json.arrayValue {
                
                let parameters = [
                    "id": Dict["id"].intValue,
                    "name": Dict["fav_stage"].stringValue,
                    "partner_id": id1,
                    "partner_found": 0,
                    "fav_stage": Dict["fav_stage"].stringValue,
                    "fav_genre": Dict["fav_genre"].stringValue
                ]
                Alamofire.request(.PUT, "http://student.howest.be/eliot.colinet/20142015/MA4/BADGET/api/users/\(id2)", parameters: parameters as? [String : AnyObject])
            }
        }
        NSKeyedArchiver.archiveRootObject(saved_user, toFile: filename)
    }
    
    func deleteUser(id:Int){
        Alamofire.request(.DELETE, "http://student.howest.be/eliot.colinet/20142015/MA4/BADGET/api/users/\(id)")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
