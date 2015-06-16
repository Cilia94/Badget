//
//  Makkers Maker
//  Major 4 - Devine Howest
//
//  Eliot Colinet & Cilia Vandenameele
//  Copyright (c) 2015. All rights reserved.

import UIKit
import CoreLocation
import CoreMotion
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
    
    var theView:Challenge1View {
        get {
            return self.view as! Challenge1View
        }
    }
    
    var locationManager:CLLocationManager!
    let reachability = Reachability.reachabilityForInternetConnection()
    var motionManager = CMMotionManager()
    
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
    var partnerName:String!
    
    var timer1:NSTimer!
    var timer2:NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSUserDefaults.standardUserDefaults().setInteger(1, forKey: "lastPage")
        
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
        locationManager.distanceFilter = 2.5
        
        self.view = Challenge1View(frame: UIScreen.mainScreen().bounds)
        
        if reachability.isReachable() {
        } else {
            println("NO Internet!")
            self.noInternetAlert()
        }
        self.fistbump()
        
        self.getPartnerName()
        
        self.theView.glassFill(200.0)
        
        self.checkDB()
        self.timer1 = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "checkDB", userInfo: nil, repeats: true)
        self.timer2 = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "rotateCompass", userInfo: nil, repeats: true)
        
    }
    
    func fistbump() {
        if self.motionManager.deviceMotionAvailable {
            self.motionManager.deviceMotionUpdateInterval = 0.1
            self.motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue()) {
                [weak self] (data: CMDeviceMotion!, error: NSError!) in
                if (data.userAcceleration.x < -1 || data.userAcceleration.x > 1) {
                    if (self!.calcDist() < 5) {
                        self?.motionManager.stopDeviceMotionUpdates()
                        self!.navigationController?.pushViewController(FreeDrinkVC(), animated: true)
                    }
                    println("Acceleration noticed! \(data.userAcceleration.x)")
                }
            }
        } else {
            println("DeviceMotion is not available")
        }
    }
    
    func reachabilityChanged(note: NSNotification) {
        let reachability = note.object as! Reachability
        
        if reachability.isReachable() {
            //println("Internet!")
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
    
    func nextPage() {
        self.timer1.invalidate()
        self.timer2.invalidate()
        locationManager.stopUpdatingLocation()
        locationManager.stopUpdatingHeading()
        self.navigationController?.pushViewController(FreeDrinkVC(), animated: true)
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        var userLocation:CLLocation = locations[0] as! CLLocation
        println("\(userLocation.coordinate.latitude, userLocation.coordinate.longitude)")
        
        self.userLat = userLocation.coordinate.latitude
        self.userLon = userLocation.coordinate.longitude
        
        GPSdegrees = self.compass(self.userLat, y1: self.userLon, x2:self.partnerLat, y2:self.partnerLon)
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateHeading newHeading: CLHeading!) {
        
        heading = newHeading.magneticHeading
        let h2 = newHeading.trueHeading
        
        if h2 >= 0 {
            heading = h2
        }
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
            UIView.animateWithDuration(1, animations: {
                self.theView.imageView.transform = CGAffineTransformMakeRotation(CGFloat(2*self.pi*self.partnerDegrees/360))
            })
            self.lastRotation = partnerDegrees
        }
        
    }
    
    func checkDB() {
        if reachability.isReachable() {
            self.getPartnerLocation()
            self.postUserLocation(userLat, lon: userLon)
        }
    }
    
    func getPartnerName() {
        
        let partner_id = NSUserDefaults.standardUserDefaults().integerForKey("partner_id")
        
        Alamofire.request(.GET, "http://student.howest.be/eliot.colinet/20142015/MA4/BADGET/api/users/\(partner_id)").responseJSON{(_,_,data,_) in
            var json = JSON(data!)
            
            self.partnerName = json["name"].stringValue
            println(self.partnerName)
            self.theView.nameP!.text = self.partnerName
        }
    }
    
    func getPartnerLocation() {
        
        let partner_id = NSUserDefaults.standardUserDefaults().integerForKey("partner_id")
        
        Alamofire.request(.GET, "http://student.howest.be/eliot.colinet/20142015/MA4/BADGET/api/locations/\(partner_id)").responseJSON{(_,_,data,_) in
            var json = JSON(data!)
            
            self.partnerLat = json["latitude"].doubleValue
            self.partnerLon = json["longitude"].doubleValue
            self.partnerName = json["name"].stringValue
            println(self.partnerName)
            
            self.GPSdegrees = self.compass(self.userLat, y1: self.userLon, x2:self.partnerLat, y2:self.partnerLon)
            
            self.theView.counter.text = "\(self.calcDist())m"
            self.theView.addSubview(self.theView.counter)
            
            println("Partner \(self.partnerLat) , \(self.partnerLon)")
            
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
        
        self.theView.glassFill(dist)
        
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
    }
    
}

