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

class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {

    @IBOutlet var mapSwitcher: NSSegmentedControl!
    @IBOutlet weak var locationMap: MKMapView!
    @IBOutlet weak var wayPointTable: NSTableView!
    
    var wayPointList: [WayPoint] = []
    var showMyLocationFlag: Bool = false;
    
    var geoCoder = CLGeocoder()
    
    let nib = NSNib(nibNamed: "TableViewCell", bundle: NSBundle.mainBundle())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationMap.showsUserLocation = showMyLocationFlag
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
    
    
    @IBAction func didClickOnTableView(sender: AnyObject) {
        
        if (wayPointList.count <= 0) {
            return
        }
        
        locationMap.selectAnnotation(wayPointList[wayPointTable.selectedRow].annotation, animated: true)
        
    }
    
    private func showActualAnnotation(){
        
    }
    
    @IBAction func addAnnotationOnMap(sender: AnyObject) {
        
        var gestureRecognizer: NSGestureRecognizer = sender as NSGestureRecognizer
        let mapViewCord = gestureRecognizer.locationInView(locationMap)
        var locCord = locationMap.convertPoint(mapViewCord, toCoordinateFromView: locationMap!)
        
        var annotation = MKPointAnnotation()
        annotation.setCoordinate(locCord)
        annotation.title = "Wegpunkt: \(wayPointList.count + 1) \(annotation.coordinate.latitude) \(annotation.coordinate.longitude)"
        
        wayPointList.append(WayPoint(latitude: locCord.latitude, longitude: locCord.longitude, annotation: annotation))
        locationMap.addAnnotation(annotation)
        
        wayPointTable.reloadData()
        
    }
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return wayPointList.count
    }
    
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let view = wayPointTable.makeViewWithIdentifier("TableViewCell", owner: self) as TableViewCell
        view.title.stringValue = wayPointList[row].locality
        view.subTitle.stringValue = wayPointList[row].locationToString()
        view.numPoint.stringValue = "\(row)"
        return view
    }
    

}

