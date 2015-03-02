//
//  TableCellView.swift
//  MotoRoute
//
//  Created by Raphael Bolliger on 02.03.15.
//  Copyright (c) 2015 Raphael Bolliger. All rights reserved.
//

import Cocoa

class TableCellView: NSView {
    
    @IBOutlet var wayPointTitle: NSTextField!
    @IBOutlet var wayPointLocation: NSTextField!

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    init(wayPoint: WayPoint) {
        super.init()
        
        wayPointTitle = NSTextField()
        wayPointLocation = NSTextField()
        
        wayPointTitle.stringValue = "Wegpunkt"
        wayPointLocation.stringValue = wayPoint.locationToString()
    }

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
    }
    
    
    @IBAction func deleteWayPoint(sender: AnyObject) {
        
        
        
    }
    
    
}
