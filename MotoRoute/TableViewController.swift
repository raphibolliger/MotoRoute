//
//  TableViewController.swift
//  MotoRoute
//
//  Created by Raphael Bolliger on 01.03.15.
//  Copyright (c) 2015 Raphael Bolliger. All rights reserved.
//

import Cocoa

class TableViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    
    
    @IBOutlet var dataTable: NSTableView!
    
    var age = [1, 2, 3, 4, 5, 6]
    var names = ["Eins", "Zwei", "Drei", "Vier", "Fünf", "Sechs"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return age.count
    }
    
    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
        
        var newString: String = "Wert nicht vorhanden!"
        
        if (tableColumn?.identifier == "age") {
            newString = "\(age[row])"
        }
        if (tableColumn?.identifier == "name") {
            newString = "\(names[row])"
        }
        
        return newString
    }
    
}
