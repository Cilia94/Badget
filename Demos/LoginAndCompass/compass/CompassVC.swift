//
//  ViewController.swift
//  whereAmI
//
//  Created by Scott Yoshimura on 4/30/15.
//  Copyright (c) 2015 west coast dev. All rights reserved.
//

import UIKit
import CoreLocation
import Darwin
import Alamofire

extension CLLocation {
    class func distance(#from: CLLocationCoordinate2D, to:CLLocationCoordinate2D) -> CLLocationDistance {
        let from = CLLocation(latitude: from.latitude, longitude: from.longitude)
        let to = CLLocation(latitude: to.latitude, longitude: to.longitude)
        return from.distanceFromLocation(to)
    }
}

class CompassVC: UIViewController, CLLocationManagerDelegate {
    
    var theView:View {
        get {
            return self.view as! View
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
    
    var userLat:Double = 0
    var userLon:Double = 0
    var partnerLat:Double = 0
    var partnerLon:Double = 0
    var lastRotation:Double = 0
    var lastHeading:Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSUserDefaults.standardUserDefaults().setInteger(2, forKey: "lastPage")
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityChanged:", name: ReachabilityChangedNotification, object: reachability)
        reachability.startNotifier()
        
        self.view.backgroundColor = UIColor.orangeColor()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        locationManager.headingFilter = 5
        //locationManager.headingFilter = kCLHeadingFilterNone
        locationManager.distanceFilter = 2.5
        
        self.view = View(frame: UIScreen.mainScreen().bounds)
        
        self.distLabel = UILabel(frame: CGRectMake(100, 250, 500, 50))
        self.distLabel.text = "Afstand!"
        self.view.addSubview(self.distLabel)
        
        self.headingLabel = UILabel(frame: CGRectMake(100, 275, 500, 50))
        self.headingLabel.text = "Heading!"
        self.view.addSubview(self.headingLabel)
        
        self.heading2Label = UILabel(frame: CGRectMake(100, 300, 500, 50))
        self.heading2Label.text = "Heading 2!"
        self.view.addSubview(self.heading2Label)
        
        self.locationLabel = UILabel(frame: CGRectMake(50, 325, 500, 50))
        self.locationLabel.text = "Location!"
        self.view.addSubview(self.locationLabel)
        
        self.partnerLabel = UILabel(frame: CGRectMake(50, 350, 500, 50))
        self.partnerLabel.text = "Partner!"
        self.view.addSubview(self.partnerLabel)
        
        self.degreesLabel = UILabel(frame: CGRectMake(100, 375, 500, 50))
        self.degreesLabel.text = "Degrees!"
        self.view.addSubview(self.degreesLabel)
        
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
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        var userLocation:CLLocation = locations[0] as! CLLocation
        println("\(userLocation.coordinate.latitude, userLocation.coordinate.longitude)")
        
        self.userLat = userLocation.coordinate.latitude
        self.userLon = userLocation.coordinate.longitude
        
        GPSdegrees = self.compass(self.userLat, y1: self.userLon, x2:self.partnerLat, y2:self.partnerLon)
        
        self.distLabel.text = "\(self.calcDist())m"
        self.locationLabel.text = "\(self.userLat) , \(self.userLon)"
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateHeading newHeading: CLHeading!) {
        
        heading = newHeading.magneticHeading
        let h2 = newHeading.trueHeading // will be -1 if we have no location info
        
        if h2 >= 0 {
            //heading = h2
        }
        
        self.headingLabel.text = "H1 : \(round(heading))°"
        self.heading2Label.text = "H2 : \(round(h2))°"
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
        
        self.degreesLabel.text = "R : \(round(partnerDegrees))°"
        
    }
    
    func checkDB() {
        //println("Check DB!")
        if reachability.isReachable() {
            //println("Internet is on")
            self.getPartnerLocation()
            self.postUserLocation(userLat, lon: userLon)
        }
    }
    
    func getPartnerLocation() {
        
        let partner_id = NSUserDefaults.standardUserDefaults().integerForKey("partner_id")
        
        Alamofire.request(.GET, "http://student.howest.be/eliot.colinet/20142015/MA4/BADGET/api/locations/\(partner_id)").responseJSON{(_,_,data,_) in
            var json = JSON(data!)
            
            for Dict in json.arrayValue {
                self.partnerLat = Dict["latitude"].doubleValue
                self.partnerLon = Dict["longitude"].doubleValue
            }
            
            self.GPSdegrees = self.compass(self.userLat, y1: self.userLon, x2:self.partnerLat, y2:self.partnerLon)
            self.distLabel.text = "\(self.calcDist())m"
            self.partnerLabel.text = "\(self.partnerLat) , \(self.partnerLon)"
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
    
    func calcDist() -> Double {
        var dist = round(CLLocation.distance(from: CLLocationCoordinate2DMake(self.userLat, self.userLon), to: CLLocationCoordinate2DMake(self.partnerLat, self.partnerLon))*10)/10
        //println("Distance : \(dist)m")
        return dist
    }
    
    func postUserLocation( lat:Double, lon:Double) {
        
        let parameters = [
            "id": NSUserDefaults.standardUserDefaults().integerForKey("loc_id"),
            "user_id": NSUserDefaults.standardUserDefaults().integerForKey("user_id"),
            "latitude": lat,
            "longitude": lon
        ]
        
        let user_id = NSUserDefaults.standardUserDefaults().integerForKey("user_id")
        
        Alamofire.request(.PUT, "http://student.howest.be/eliot.colinet/20142015/MA4/BADGET/api/locations/\(user_id)", parameters: parameters as? [String : AnyObject])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

