//
//  WayPoint.swift
//  MotoRoute
//
//  Created by Raphael Bolliger on 02.03.15.
//  Copyright (c) 2015 Raphael Bolliger. All rights reserved.
//

import Cocoa
import MapKit

class WayPoint {
    
    var locality: String
    var latitude: Double
    var longitude: Double
    var annotation: MKPointAnnotation
    
    init(locality: String, latitude: Double, longitude: Double, annotation: MKPointAnnotation) {
        
        self.locality = locality
        self.latitude = latitude
        self.longitude = longitude
        self.annotation = annotation
        
    }
    
    func getLocation() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    func locationToString() -> String {
        return "\(latitude)  \(longitude)"
    }

}
