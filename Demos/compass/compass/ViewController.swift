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
import AudioToolbox

extension CLLocation {
    class func distance(#from: CLLocationCoordinate2D, to:CLLocationCoordinate2D) -> CLLocationDistance {
        let from = CLLocation(latitude: from.latitude, longitude: from.longitude)
        let to = CLLocation(latitude: to.latitude, longitude: to.longitude)
        return from.distanceFromLocation(to)
    }
}

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var theView:View {
        get {
            return self.view as! View
        }
    }
    
    var locationManager:CLLocationManager!
    var distLabel:UILabel!
    
    let pi = M_PI
    
    var compassReading:Double = 0
    var GPSdegrees:Double = 0
    var heading:Double = 0
    var partnerDegrees:Double = 0
    var user_id:Int = 2
    var userLat:Double = 0
    var userLon:Double = 0
    var partner_id:Int = 4   // 5 Kortrijk   4 Apple
    var partnerLat:Double = 0
    var partnerLon:Double = 0
    var lastRotation:Double = 0
    var lastHeading:Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.orangeColor()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        locationManager.headingFilter = 10
        
        self.view = View(frame: UIScreen.mainScreen().bounds)
        
        self.distLabel = UILabel(frame: CGRectMake(150, 450, 500, 50))
        self.view.addSubview(self.distLabel)
        
        self.checkDB()
        NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "checkDB", userInfo: nil, repeats: true)
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "rotateCompass", userInfo: nil, repeats: true)
    }
    
    func checkDB() {
        println("Check DB!")
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        self.getPartnerLocation()
        self.postUserLocation(userLat, lon: userLon)
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        var userLocation:CLLocation = locations[0] as! CLLocation
        println("\(userLocation.coordinate.latitude, userLocation.coordinate.longitude)")
        
        self.userLat = userLocation.coordinate.latitude
        self.userLon = userLocation.coordinate.longitude
        
        GPSdegrees = self.compass(self.userLat, y1: self.userLon, x2:self.partnerLat, y2:self.partnerLon)
        
        self.distLabel.text = "\(self.calcDist())m"
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateHeading newHeading: CLHeading!) {
        
        heading = newHeading.magneticHeading
        let h2 = newHeading.trueHeading // will be -1 if we have no location info
        
        if h2 >= 0 {
            heading = h2
        }
    }
    
    func rotateCompass() {
        partnerDegrees = GPSdegrees - heading
        if (abs(self.lastRotation - partnerDegrees) > 10) {
            println("Rotate phone \(partnerDegrees)°!")
            self.theView.imageView.transform = CGAffineTransformMakeRotation(CGFloat(2*pi*partnerDegrees/360))
            self.lastRotation = partnerDegrees
        } else {
            println("Change to small to rotate!")
        }
        
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
            
            self.distLabel.text = "\(self.calcDist())m"
        }
    }
    
    func postUserLocation( lat:Double, lon:Double) {
        
        Alamofire.request(.GET, "http://student.howest.be/eliot.colinet/20142015/MA4/BADGET/api/users/\(self.user_id)").responseJSON{(_,_,data,_) in
            var json = JSON(data!)
            
            for Dict in json.arrayValue {
                
                let parameters = [
                    "id": Dict["id"].intValue,
                    "user_id": self.user_id,
                    "latitude": lat,
                    "longitude": lon
                ]
                
                Alamofire.request(.PUT, "http://student.howest.be/eliot.colinet/20142015/MA4/BADGET/api/locations/2", parameters: parameters as? [String : AnyObject])
            }
        }
    }
    
    func compass(x1:Double, y1:Double, x2:Double, y2:Double) -> Double {
        
        var radians = atan2((y1 - y2), (x1 - x2));
        
        compassReading = radians * (180 / pi);
        
        return compassReading
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

