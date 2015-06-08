//
//  Challenge1ViewController.swift
//  Badget
//
//  Created by Eliot Colinet on 07-06-15.
//  Copyright (c) 2015 Eliot Colinet. All rights reserved.
//

import UIKit
import CoreLocation
import Darwin
import Alamofire
import AudioToolbox

extension CLLocation {
    class func distance(#from: CLLocationCoordinate2D, to:CLLocationCoordinate2D) -> CLLocationDistance {
        let from = CLLocation(latitude: from.latitude, longitude: from.longitude)
        let to = CLLocation(latitude: to.latitude, longitude: to.longitude)
        return from.distanceFromLocation(to)
    }
}

class Challenge1ViewController: UIViewController, CLLocationManagerDelegate {
    
    var theView:Challenge1View {
        get {
            return self.view as! Challenge1View
        }
    }
    
    var locationManager:CLLocationManager!
    let reachability = Reachability.reachabilityForInternetConnection()
    
    var distLabel:UILabel!
    var headingLabel:UILabel!
    var heading2Label:UILabel!
    var locationLabel:UILabel!
    var partnerLabel:UILabel!
    var degreesLabel:UILabel!
    
    let pi = M_PI
    
    var compassReading:Double = 0
    var GPSdegrees:Double = 0
    var heading:Double = 0
    var partnerDegrees:Double = 0
    var user_id:Int = 2
    var userLat:Double = 0
    var userLon:Double = 0
    var partner_id:Int = 5   // 5 Kortrijk   4 Apple   3 PizzaHut
    var partnerLat:Double = 0
    var partnerLon:Double = 0
    var lastRotation:Double = 0
    var lastHeading:Double = 0

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityChanged:", name: ReachabilityChangedNotification, object: reachability)
        reachability.startNotifier()
        
        self.view.backgroundColor = UIColor.orangeColor()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        //locationManager.headingFilter = 5
        locationManager.headingFilter = kCLHeadingFilterNone
        locationManager.distanceFilter = 2.5
        
        self.view = Challenge1View(frame: UIScreen.mainScreen().bounds)
        
//        self.distLabel = UILabel(frame: CGRectMake(100, 250, 500, 50))
//        self.distLabel.text = "Afstand!"
//        self.view.addSubview(self.distLabel)
//        
//        self.headingLabel = UILabel(frame: CGRectMake(100, 275, 500, 50))
//        self.headingLabel.text = "Heading!"
//        self.view.addSubview(self.headingLabel)
//        
//        self.heading2Label = UILabel(frame: CGRectMake(100, 300, 500, 50))
//        self.heading2Label.text = "Heading 2!"
//        self.view.addSubview(self.heading2Label)
//        
//        self.locationLabel = UILabel(frame: CGRectMake(50, 325, 500, 50))
//        self.locationLabel.text = "Location!"
//        self.view.addSubview(self.locationLabel)
//        
//        self.partnerLabel = UILabel(frame: CGRectMake(50, 350, 500, 50))
//        self.partnerLabel.text = "Partner!"
//        self.view.addSubview(self.partnerLabel)
//        
//        self.degreesLabel = UILabel(frame: CGRectMake(100, 375, 500, 50))
//        self.degreesLabel.text = "Degrees!"
//        self.view.addSubview(self.degreesLabel)
        
        if reachability.isReachable() {
        } else {
            println("NO Internet!")
            self.noInternetAlert()
        }
        self.checkDB()
        NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "checkDB", userInfo: nil, repeats: true)
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "rotateCompass", userInfo: nil, repeats: true)
    }
    
    func reachabilityChanged(note: NSNotification) {
        let reachability = note.object as! Reachability
        
        if reachability.isReachable() {
            //println("Internet is back!")
        } else {
            self.noInternetAlert()
        }
    }
    
    func noInternetAlert() {
        let alert = UIAlertController(
            title: "GEEN INTERNET",
            message: "Gelieve uw internetverbinding in te schakelen",
            preferredStyle: UIAlertControllerStyle.Alert
        )
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action) -> Void in
            // Code
        }
        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func checkDB() {
        //println("Check DB!")
        if reachability.isReachable() {
            //println("Internet is on")
            //AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            self.getPartnerLocation()
            self.postUserLocation(userLat, lon: userLon)
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        var userLocation:CLLocation = locations[0] as! CLLocation
        println("\(userLocation.coordinate.latitude, userLocation.coordinate.longitude)")
        
        self.userLat = userLocation.coordinate.latitude
        self.userLon = userLocation.coordinate.longitude
        
        GPSdegrees = self.compass(self.userLat, y1: self.userLon, x2:self.partnerLat, y2:self.partnerLon)
        
//        self.theView.counter.text = "\(self.calcDist())m"
//        self.theView.addSubview(self.theView.counter)
        
         //let counter = UILabel(frame: CGRectMake(60, 405, 80, 40))
        //counter.text = "\(self.calcDist())m"
        //counter.backgroundColor = UIColor.blueColor()
        //self.view.addSubview(counter)
        //self.locationLabel.text = "\(self.userLat) , \(self.userLon)"
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateHeading newHeading: CLHeading!) {
        
        heading = newHeading.magneticHeading
        let h2 = newHeading.trueHeading // will be -1 if we have no location info
        
        if h2 >= 0 {
            //heading = h2
        }
        
        //self.headingLabel.text = "H1 : \(round(heading))°"
        //self.heading2Label.text = "H2 : \(round(h2))°"
    }
    
    func rotateCompass() {
        partnerDegrees = GPSdegrees - heading
        if (partnerDegrees < 0) {
            partnerDegrees += 360
        } else if (partnerDegrees > 360) {
            partnerDegrees -= 360
        }
        if (abs(self.lastRotation - partnerDegrees) > 5) {
            //println("Rotate phone \(partnerDegrees)°!")
            self.theView.imageView.transform = CGAffineTransformMakeRotation(CGFloat(2*pi*partnerDegrees/360))
            self.lastRotation = partnerDegrees
        } else {
            //println("Change to small to rotate! \(partnerDegrees)°")
        }
        
        //self.degreesLabel.text = "R : \(round(partnerDegrees))°"
        
    }
    
    func calcDist() -> Double {
        var dist = round(CLLocation.distance(from: CLLocationCoordinate2DMake(self.userLat, self.userLon), to: CLLocationCoordinate2DMake(self.partnerLat, self.partnerLon))*10)/10
        //println("Distance : \(dist)m")
        return dist
    }
    
    func getPartnerLocation() {
        
        Alamofire.request(.GET, "http://student.howest.be/eliot.colinet/20142015/MA4/BADGET/api/locations/\(self.partner_id)").responseJSON{(_,_,data,_) in
            var json = JSON(data!)
            
            for Dict in json.arrayValue {
                self.partnerLat = Dict["latitude"].doubleValue
                self.partnerLon = Dict["longitude"].doubleValue
            }
            
            self.GPSdegrees = self.compass(self.userLat, y1: self.userLon, x2:self.partnerLat, y2:self.partnerLon)
            
            self.theView.counter.text = "\(self.calcDist())m"
            self.theView.addSubview(self.theView.counter)
            
            //self.distLabel.text = "\(self.calcDist())m"
            //self.partnerLabel.text = "\(self.partnerLat) , \(self.partnerLon)"
        }
    }
    
    func postUserLocation( lat:Double, lon:Double) {
        
        Alamofire.request(.GET, "http://student.howest.be/eliot.colinet/20142015/MA4/BADGET/api/users/\(self.user_id)").responseJSON{(_,_,data,_) in
            var json = JSON(data!)
            
            for Dict in json.arrayValue {
                
                var loc_id = Dict["id"].intValue
                
                let parameters = [
                    "id": loc_id,
                    "user_id": self.user_id,
                    "latitude": lat,
                    "longitude": lon
                ]
                
                Alamofire.request(.PUT, "http://student.howest.be/eliot.colinet/20142015/MA4/BADGET/api/locations/\(loc_id)", parameters: parameters as? [String : AnyObject])
            }
        }
    }
    
    func compass(x1:Double, y1:Double, x2:Double, y2:Double) -> Double {
        
        var radians = atan2((y1 - y2), (x1 - x2))
        compassReading = radians * (180 / pi);
        if (compassReading < 0) {
            compassReading += 360
        } else if (compassReading > 360) {
            compassReading -= 360
        }
        return compassReading
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
