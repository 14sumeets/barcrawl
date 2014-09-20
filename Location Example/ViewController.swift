//
//  ViewController.swift
//  Location Example
//
//  Created by Sumeet Sharma on 8/26/14.
//  Copyright (c) 2014 Sumeet Sharma. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Alamofire

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

	let locationManager = CLLocationManager()
    var firstTime = true
    @IBOutlet weak var theMap: MKMapView!
    
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
            }
            else
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
        if firstTime
        {
            var longDelta : CLLocationDegrees = 0.01
            var latDelta : CLLocationDegrees = 0.01
            var theSpan : MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
            var theRegion : MKCoordinateRegion = MKCoordinateRegionMake(placemark.location.coordinate, theSpan)
            theMap.setRegion(theRegion, animated: true)
            firstTime = false
        }
        //theMap.removeAnnotation()
        println(placemark.location.coordinate.latitude)
        println(placemark.location.coordinate.longitude)
        println(placemark.locality != nil ? placemark.locality : "")
        println(placemark.postalCode != nil ? placemark.postalCode : "")
        println(placemark.administrativeArea != nil ? placemark.administrativeArea : "")
        println(placemark.country != nil ? placemark.country : "")
        Alamofire.request(.POST, "http://localhost:3000", parameters: ["latitude": placemark.location.coordinate.latitude, "longitude":placemark.location.coordinate.longitude])
            .responseString { (request, response, data, error) in
                println("sever's response: ")
                println(data)
        }
    }
    
    @IBAction func pinMyLocation(sender: AnyObject)
    {
        var annotation = MKPointAnnotation()
        annotation.setCoordinate(locationManager.location.coordinate)
        theMap.addAnnotation(annotation)
        //theMap.
    }
    @IBAction func findMyLocation(sender: AnyObject)
    {
        var longDelta : CLLocationDegrees = 0.01
        var latDelta : CLLocationDegrees = 0.01
        var theSpan : MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        var theRegion : MKCoordinateRegion = MKCoordinateRegionMake(locationManager.location.coordinate, theSpan)
        theMap.setRegion(theRegion, animated: true)
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!)
    {
        println("error" + error.localizedDescription)
    }
                            
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
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
