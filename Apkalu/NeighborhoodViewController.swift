//
//  NeighborhoodViewController.swift
//  Apkalu
//
//  Created by Robert Passemar on 12/8/15.
//  Copyright (c) 2015 TreeNine. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class NeighborhoodViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let homeInfo = HomeInfo.query()
        homeInfo?.findObjectsInBackgroundWithBlock({ (results: [AnyObject]?, error: NSError?) -> Void in
            for result in results! {
                var propertyAddress = result["address"] as? String
                var propertyCity = result["city"] as? String
                var propertyState = result["state"] as? String
                var space = " "
//                var location = "\(propertyAddress) \(propertyCity) \(propertyState)"
                let location = propertyAddress!+space+propertyCity!+space+propertyState!
                var geocoder:CLGeocoder = CLGeocoder()
                geocoder.geocodeAddressString(location, completionHandler: { (placemarks, error) -> Void in
                    if ((error) != nil) {
                        println("Error", error)
                    } else if let placemark = placemarks?[0] as? CLPlacemark {
                        var placemark:CLPlacemark = placemarks[0] as! CLPlacemark
                        var coordinates:CLLocationCoordinate2D = placemark.location.coordinate
                        var pointAnnotation:MKPointAnnotation = MKPointAnnotation()
                        pointAnnotation.coordinate = coordinates
                        
                        self.mapView?.addAnnotation(pointAnnotation)
                        self.mapView?.centerCoordinate = coordinates
                        self.mapView?.selectAnnotation(pointAnnotation, animated: true)
                        var locationCoordinates:CLLocation = placemark.location
                        self.centerMapOnLocation(locationCoordinates)
                    }
                })
            }
        })
        // set initial location in San Jose
//        let initialLocation = CLLocation(latitude: 37.344482, longitude: -121.883535)
//        
//        centerMapOnLocation(initialLocation)
    }
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
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
