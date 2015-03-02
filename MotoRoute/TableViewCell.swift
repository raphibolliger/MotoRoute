//
//  TableViewCell.swift
//  MotoRoute
//
//  Created by Raphael Bolliger on 02.03.15.
//  Copyright (c) 2015 Raphael Bolliger. All rights reserved.
//

import Cocoa

class TableViewCell: NSView {

    @IBOutlet var title: NSTextField!
    @IBOutlet var subTitle: NSTextField!
    @IBOutlet var numPoint: NSTextField!
    
    
    
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
    }
    
}
