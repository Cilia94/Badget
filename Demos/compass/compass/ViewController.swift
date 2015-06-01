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

extension CLLocation {
    // In meteres
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
    
    let pi = M_PI
    
    var compassReading:Double = 0
    var GPSdegrees:Double = 0
    var heading:Double = 0
    var partnerDegrees:Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("View Did Load")
        
        self.view.backgroundColor = UIColor.orangeColor()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        
        self.view = View(frame: UIScreen.mainScreen().bounds)
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        //println(locations)
        
        var userLocation:CLLocation = locations[0] as! CLLocation
        
        //println("\(userLocation.coordinate.latitude, userLocation.coordinate.longitude)")
        //println("\(userLocation.coordinate.longitude)")
        
        GPSdegrees = self.compass(userLocation.coordinate.latitude, y1: userLocation.coordinate.longitude, x2:37.331280, y2:-122.030411)
        
        println("GPSdegrees : \(GPSdegrees)")
        println("partnerDegrees : \(GPSdegrees - heading)")
        partnerDegrees = GPSdegrees - heading
        
        var locationUser = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude)
        var locationPartner = CLLocationCoordinate2DMake(37.331280, -122.030411)
        
        var dist = round(CLLocation.distance(from: locationUser, to: locationPartner)*10)/10
        //var distKMeters = Int(dist/1000);
        
        //println("Distance : \(dist)m")
        
        println(CGFloat(partnerDegrees))

        self.theView.imageView.transform = CGAffineTransformMakeRotation(CGFloat(2*pi*partnerDegrees/360))
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateHeading newHeading: CLHeading!) {
        
        heading = newHeading.magneticHeading
        let h2 = newHeading.trueHeading // will be -1 if we have no location info
        
        if h2 >= 0 {
            heading = h2
        }
        
        println("Heading : \(heading)")
        
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

