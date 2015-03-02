//
//  WayPoint.swift
//  MotoRoute
//
//  Created by Raphael Bolliger on 02.03.15.
//  Copyright (c) 2015 Raphael Bolliger. All rights reserved.
//

import Cocoa
import MapKit
import CoreLocation

class WayPoint {
    
    var latitude: Double
    var longitude: Double
    var annotation: MKPointAnnotation
    var geoLocation = CLGeocoder()
    var locality: String = "Fuu"
    
    init(latitude: Double, longitude: Double, annotation: MKPointAnnotation) {
        
        self.latitude = latitude
        self.longitude = longitude
        self.annotation = annotation
        
        var placemark : CLPlacemark!
        
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        geoLocation.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            if (error != nil) {
                println("Reverse geocode failed with error")
            }
            if placemarks.count > 0 {
                placemark = placemarks[0] as CLPlacemark
                self.setLocality(placemark.locality)
            } else {
                println("Problem with the date recieved from geocoder")
            }
        })
        
        22
        
    }
    
    func setLocality(l: String) {
        locality = l
    }
    
    func getLocation() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    func locationToString() -> String {
        
        return "\(latitude)  \(longitude)"
        
    }

}
