//
//  ViewController.swift
//  Location Example
//
//  Created by Sumeet Sharma on 8/26/14.
//  Copyright (c) 2014 Sumeet Sharma. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

	let locationManager = CLLocationManager()
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: AnyObject!)
    {
        func foo (placemarks: [AnyObject]!, error: NSError!) -> Void
        {
            if error != nil
            {
                println("Reverse geocode failed: " + error.localizedDescription)
                return
            }
            println("got some location data")
            if placemarks.count > 0
            {
                let pm = placemarks[0] as CLPlacemark
                self.displayLocationInfo(pm)
            } else
            {
                println("Problem with the data received from geocoder")
            }
        }
        CLGeocoder().reverseGeocodeLocation(manager.location, foo)
    }
    
    func displayLocationInfo(placemark: CLPlacemark)
    {
        println("displaying location info")
        //locationManager.stopUpdatingLocation()
        //placemark.location.co
        println(placemark.locality != nil ? placemark.locality : "")
        println(placemark.postalCode != nil ? placemark.postalCode : "")
        println(placemark.administrativeArea != nil ? placemark.administrativeArea : "")
        println(placemark.country != nil ? placemark.country : "")
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!)
    {
        println("error" + error.localizedDescription)
    }
                            
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.requestWhenInUseAuthorization()
    }
    
    // UI button callback
    @IBAction func findMyLocation(sender: AnyObject)
    {
    	println("getting updated location...")
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
