//
//  ViewController.swift
//  MotoRoute
//
//  Created by Raphael Bolliger on 01.03.15.
//  Copyright (c) 2015 Raphael Bolliger. All rights reserved.
//

import Cocoa
import CoreLocation
import MapKit

class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate, MKMapViewDelegate {

    @IBOutlet var mapSwitcher: NSSegmentedControl!
    @IBOutlet weak var locationMap: MKMapView!
    @IBOutlet weak var wayPointTable: NSTableView!
    
    var placemarkList: [CLPlacemark] = []
    var wayPointList: [WayPoint] = []
    var showMyLocationFlag: Bool = false;
    
    var geoLocation = CLGeocoder()
    
    let nib = NSNib(nibNamed: "TableViewCell", bundle: NSBundle.mainBundle())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationMap.showsUserLocation = showMyLocationFlag
        locationMap.delegate = self
        
        self.wayPointTable.registerNib(nib!, forIdentifier: "TableViewCell")
        // Do any additional setup after loading the view.
        
        
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func enableMyLocation(sender: AnyObject) {
        locationMap.showsUserLocation = !showMyLocationFlag
    }
    
    @IBAction func switchMap(sender: AnyObject) {
        
    }
    
    private func showActualAnnotation(){
        
    }
    
    @IBAction func addAnnotationOnMap(sender: AnyObject) {
        
        var gestureRecognizer: NSGestureRecognizer = sender as NSGestureRecognizer
        let mapViewCord = gestureRecognizer.locationInView(locationMap)
        
        var locCord = locationMap.convertPoint(mapViewCord, toCoordinateFromView: locationMap!)
        
        loadLocality(locCord.latitude, longitude: locCord.longitude)
        
        
    }
    
    func loadLocality(latitude: Double, longitude: Double) {
        
        var placemark : CLPlacemark!
        var location = CLLocation(latitude: latitude, longitude: longitude)
        
        geoLocation.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            if (error != nil) {
                println("Reverse geocode failed with error")
            }
            if placemarks.count > 0 {
                placemark = placemarks[0] as CLPlacemark
                println(placemark.locality)
                
                self.placemarkList.append(placemark)
                
                var annotation = MKPointAnnotation()
                annotation.setCoordinate(CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
                annotation.title = placemark.locality
                annotation.subtitle = "\(annotation.coordinate.latitude) \(annotation.coordinate.longitude)"
                
                var wayPointNew = WayPoint(locality: placemark.locality ,latitude: latitude, longitude: longitude, annotation: annotation)
                
                self.wayPointList.append(wayPointNew)
                self.locationMap.addAnnotation(annotation)
                
                self.wayPointTable.reloadData()
                
            } else {
                println("Problem with the date recieved from geocoder")
            }
        })
        
    }
    
    @IBAction func deleteWayPoint(sender: AnyObject) {
        
        if wayPointList.count <= 0 { return }
        locationMap.removeAnnotation(wayPointList[wayPointTable.selectedRow].annotation)
        wayPointList.removeAtIndex(wayPointTable.selectedRow)
        wayPointTable.reloadData()
        
    }
    
    @IBAction func calculateRoute(sender: AnyObject) {
        
        for var index = 0; index < placemarkList.count-1; index++ {
            
            var startPoint = MKMapItem(placemark: MKPlacemark(placemark: placemarkList[index]))
            var endPoint = MKMapItem(placemark: MKPlacemark(placemark: placemarkList[index+1]))
            
            let request = MKDirectionsRequest()
            request.setSource(startPoint)
            request.setDestination(endPoint)
            request.requestsAlternateRoutes = true
            
            let directions = MKDirections(request: request)
            
            directions.calculateDirectionsWithCompletionHandler({
                (response: MKDirectionsResponse!, error: NSError!) in
                
                if error != nil {
                    // Handle error
                } else {
                    self.locationMap.addOverlay(response.routes[0].polyline, level: MKOverlayLevel.AboveRoads)
                    println("\(response.destination.description)")
                }
                
            })
            
        }
        
    }
    
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return wayPointList.count
    }
    
    func tableViewSelectionDidChange(notification: NSNotification) {
        
        if (wayPointList.count <= 0) {
            return
        }
        
        locationMap.selectAnnotation(wayPointList[wayPointTable.selectedRow].annotation, animated: true)
        
    }
    
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let view = wayPointTable.makeViewWithIdentifier("TableViewCell", owner: self) as TableViewCell
        view.title.stringValue = wayPointList[row].locality
        view.subTitle.stringValue = wayPointList[row].locationToString()
        return view
    }
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        let renderer = MKPolylineRenderer(overlay: overlay)
        
        renderer.strokeColor = NSColor.blueColor()
        renderer.lineWidth = 5.0
        return renderer
    }

}

